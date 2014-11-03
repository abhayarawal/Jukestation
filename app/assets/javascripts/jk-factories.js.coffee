define 'jkFactories', ['angular', 'angularResource', 'underscore'], (ng, ngResource, _) ->
	jkFactories = ng.module 'Jukestation.jkFactories', ['ngResource']

	_csrf = $('meta[name=csrf-token]').attr('content')

	jkFactories.config ['$httpProvider', ($httpProvider) ->
		$httpProvider.defaults.headers.patch = { 'Content-Type': 'application/json;charset=utf-8' }
		$httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
	]

	jkFactories.factory 'Video', ['$resource', ($resource) ->
		$resource '/videos/:id', null,
			query:
				method: 'GET'
				isArray: true
			update: 
				method: 'PATCH'
	]

	jkFactories.factory 'jukePlayer', ['$window', ($window) ->
		{
			init: ->
				_ref = @
				vid = "XjwZAa2EjKA"
				vid = @.queue[0].vid unless @.queue.length is 0
				YT_url = "//www.youtube.com/iframe_api"
				unless document.querySelector "[src='#{YT_url}']"
		      s = document.createElement 'script'
		      s.src = YT_url
		      document.head.appendChild s
				$window.onYouTubeIframeAPIReady = ->
					_ref.player = new YT.Player 'player',
						videoId: vid
						playerVars:
							controls: 0
							iv_load_policy: 3
							showinfo: 0
						events:
							onReady: _ref.ready
							onStateChange: _ref.state
			ready: (e) ->
				e.target.mute()
				e.target.playVideo()
			state: (e) ->
				console.log e
			play: () ->
				@.player.playVideo()
			pause: () ->
				@.player.pauseVideo()
			queue: []
			shuffleState: false
			fxqueue: []
			sync: (videos) ->
				_ref = @
				angular.forEach videos, (video) ->
					video['deleted'] = false
					_ref.queue.push video
				@.init()
			pushq: (video) ->
				@.queue.push video
			remove: (vid) ->
				_ref = @
				angular.forEach @.queue, (video, i) ->
					_ref.queue.splice i, 1 if vid is video.vid
				angular.forEach @.fxqueue, (video, i) ->
					_ref.fxqueue.splice i, 1 if vid is video.vid
			pushfxq: (video) ->
				@.fxqueue.push video
			shuffle:  ->
				_ref = @
				shuffled = _.shuffle @.queue 
				angular.forEach shuffled, (video, i) ->
					_ref.queue[i] = video
		}
	]

	jkFactories.factory 'playlist', ['Video', '$http', '$q', 'jukePlayer', (Video, $http, $q, jukePlayer) ->
		{
			init: ->
				_ref = @
				Video.query().$promise.then (list) ->
					_ref.pid = list[0] 
					angular.forEach list[1], (video) ->
						_ref.playlist.push video
					jukePlayer.sync _ref.playlist
			pid: false,
			playlist: [],
			exist: (video) ->
				duplicate = false
				angular.forEach @.playlist, (entry) ->
					duplicate = true if video.vid is entry.vid
				duplicate
			undo: (entry) ->
				@.playlist[entry]['deleted'] = false
				Video.save @.playlist[entry]
				jukePlayer.pushq @.playlist[entry]
			enqueue: (entry) ->
				duplicate = @.exist entry
				unless duplicate
					jukePlayer.pushq entry
					@.playlist.push entry
					if @.pid
						Video.save entry
			remove: (entry) ->
				$oid = @.playlist[entry].vid
				if @.pid
					Video.remove id: $oid
					@.playlist[entry]['deleted'] = true
				else
					@.playlist.splice entry, 1
				jukePlayer.remove $oid
			sync: ->
				unless @.pid
					ret = $q.defer()
					$http.post("/sync", {videos: @.playlist}
					).success (uri) ->
						if uri.length is 1
							window.location = "/pl/#{uri[0]}"
		}
	]

	jkFactories.factory 'jkSearch', ['$http', '$q', 'playlist', ($http, $q, playlist) ->
		fetch_yt_videos: (query) ->
			api = "//gdata.youtube.com/feeds/api/videos?category=Music"
			options = 
				q: query
				'max-results': 12
				alt: 'json'
			ret = $q.defer()
			$http.get(api, params: options, headers: {'X-CSRF-Token': undefined}
			).success (videos) ->
				_ref = []
				angular.forEach videos.feed.entry, (entry, i) ->
          _ref.push
            vid: entry.id.$t.match(/([a-z0-9-_]+)$/i)[1]
            title: entry.title.$t
            thumbnail: entry.media$group.media$thumbnail[0].url
            duration: entry.media$group.yt$duration.seconds
            deleted: false
          _ref[i]['inqueue'] = playlist.exist _ref[i]
        ret.resolve _ref

			# Return the videos
			ret
	]

	jkFactories