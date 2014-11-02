define 'jkFactories', ['angular', 'angularResource'], (ng, ngResource) ->
	jkFactories = ng.module 'Jukestation.jkFactories', ['ngResource']

	_csrf = $('meta[name=csrf-token]').attr('content')

	jkFactories.config ['$httpProvider', ($httpProvider) ->
		$httpProvider.defaults.headers.patch = { 'Content-Type': 'application/json;charset=utf-8' }
		$httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
	]

	jkFactories.factory 'Video', ['$resource', ($resource) ->
		$resource '//jk-dev.com:3000/videos/:id', null,
			query:
				method: 'GET'
				isArray: true
			update: 
				method: 'PATCH'
	]

	jkFactories.factory 'jkSearch', ['$http', '$q', ($http, $q) ->
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
				angular.forEach videos.feed.entry, (entry) ->
          _ref.push
            vid: entry.id.$t.match(/([a-z0-9-_]+)$/i)[1]
            title: entry.title.$t
            thumbnail: entry.media$group.media$thumbnail[0].url
            duration: entry.media$group.yt$duration.seconds
        ret.resolve _ref

			# Return the videos
			ret
	]

	jkFactories.factory 'jukePlayer', ['Video', '$http', '$q', (Video, $http, $q) ->
		{
			init: ->
				_ref = @
				Video.query().$promise.then (videos) ->
					tmp = []
					if videos.length is 2 then tmp = videos[1]; _ref.pid = true else	tmp = videos
					angular.forEach tmp, (video) ->
						_ref.playlist.push video
			pid: false,
			playlist: [],
			enqueue: (entry) ->
				duplicate = false
				angular.forEach @.playlist, (video) ->
					duplicate = true if video.vid is entry.vid
				unless duplicate
					@.playlist.push entry
					if @.pid
						Video.save(entry).$promise.then (_video) ->
							console.log "#{_video.title} saved to playlist"
			remove: (entry) ->
				$oid = @.playlist[entry].vid
				if @.pid
					Video.remove id: $oid
				@.playlist.splice entry, 1
			sync: ->
				ret = $q.defer()
				$http.post("/sync", {videos: @.playlist}
				).success (uri) ->
					if uri.length is 1
						window.location = "/pl/#{uri[0]}"
		}
	]

	jkFactories