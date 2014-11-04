define 'jkControllers', ['angular', 'jkFactories', 'grid'], (ng, jkFactories, grid) ->
	jkControllers = ng.module 'Jukestation.jkControllers', ['Jukestation.jkFactories']

	jkControllers.controller 'jukeController', ['$scope', '$interval', 'jukePlayer', 'playlist', ($scope, $interval, jukePlayer, playlist) ->
		playlist.init()
		$scope.playlist = playlist.playlist
		searchElm = $('.search-wrap')

		$scope.queue = jukePlayer.queue
		$scope.fxqueue = jukePlayer.fxqueue

		$scope.seekvolume = (n) ->
			jukePlayer.volume n

		$scope.seekTo = (n) ->
			jukePlayer.seekTo n

		$interval ->
			if jukePlayer.playing
				$scope.seek = jukePlayer.seek()
		, 100

		$scope.pushfxq = (video) ->
			jukePlayer.pushfxq video

		$scope.togglegrid = ->
			grid.togglegrid()

		$scope.shuffle = ->
			jukePlayer.shuffle()

		$scope.remove = (entry) ->
			playlist.remove(entry)

		$scope.undo = (entry) ->
			playlist.undo entry

		$scope.sync = ->
			playlist.sync()

		$scope.pause = ->
			jukePlayer.pause()

		$scope.playvideo = (video) ->
			jukePlayer.playvideo video

		$scope.mute = ->
			jukePlayer.mute()

		$scope.unmute = ->
			jukePlayer.unmute()

		$(document).keyup (event) ->
			if event.keyCode is 27
				searchElm.hide()
		$(document).keypress (event) ->
				unless $('#q').is ':focus'
					searchElm.show()
					$('#q').focus()
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