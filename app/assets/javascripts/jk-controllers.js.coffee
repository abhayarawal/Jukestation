define 'jkControllers', ['angular', 'jkFactories', 'grid'], (ng, jkFactories, grid) ->
	jkControllers = ng.module 'Jukestation.jkControllers', ['Jukestation.jkFactories']

	jkControllers.controller 'jukeController', ['$scope', '$interval', 'jukePlayer', 'playlist', 'related', ($scope, $interval, jukePlayer, playlist, related) ->
		playlist.init()
		$scope.playlist = playlist.playlist
		searchElm = $('.search-wrap')

		$scope.queue = jukePlayer.queue
		$scope.fxqueue = jukePlayer.fxqueue
		$scope.track = jukePlayer.track
		$scope.playing = false
		$scope.muted = false
		$scope.shuffled = false
		$scope.grid = false
		$scope.relatedvideos = []

		$scope.seekvolume = (n) ->
			jukePlayer.volume n

		$scope.$watch (() -> jukePlayer.playing), (playing) ->
			$scope.playing = playing

		$scope.$watch (() -> jukePlayer.track), (track) ->
			$scope.track = track + 1

		$scope.seekTo = (n) ->
			jukePlayer.seekTo n

		$interval ->
			if jukePlayer.playing
				$scope.seek = jukePlayer.seek()
		, 100

		$scope.next = ->
			jukePlayer.next()

		$scope.previous = ->
			jukePlayer.previous()

		$scope.pushfxq = (video) ->
			jukePlayer.pushfxq video

		$scope.togglegrid = ->
			grid.togglegrid()
			$scope.grid = !$scope.grid

		$scope.shuffle = ->
			$scope.shuffled = !$scope.shuffled
			playlist.shuffle $scope.shuffled

		$scope.remove = (entry) ->
			playlist.remove(entry)

		$scope.undo = (entry) ->
			playlist.undo entry

		$scope.sync = ->
			playlist.sync()

		$scope.playpause = ->
			if $scope.playing
				jukePlayer.pause()
			else
				jukePlayer.play()

		$scope.playvideo = (video) ->
			jukePlayer.playvideo video

		$scope.mute = ->
			if $scope.muted
				jukePlayer.unmute()
			else
				jukePlayer.mute()
			$scope.muted = !$scope.muted

		$(document).keyup (event) ->
			if event.keyCode is 27
				searchElm.hide()
		$(document).keypress (event) ->
				unless $('#q').is ':focus'
					searchElm.show()
					$('#q').focus()

					$scope.relatedvideos = related.fetch_related_videos()
	]

	jkControllers.directive 'repeatEdge', ->
		((scope, element, attrs)->
			grid.setblocks() if scope.$last
		)

	jkControllers.controller 'ytsController', ['$scope', 'jkSearch', 'playlist', ($scope, jkSearch, playlist) ->
		$scope.$watch 'query', (q) ->
			defer = jkSearch.fetch_yt_videos q
			defer.promise.then (d) ->
				$scope.ytvideos = d

		$scope.enqueue = (entry) ->
			playlist.enqueue entry
	]

	jkControllers