define 'jkControllers', ['angular', 'jkFactories', 'grid'], (ng, jkFactories, grid) ->
	jkControllers = ng.module 'Jukestation.jkControllers', ['Jukestation.jkFactories']

	jkControllers.controller 'jukeController', ['$scope', 'jukePlayer', 'playlist', ($scope, jukePlayer, playlist) ->
		playlist.init()
		$scope.playlist = playlist.playlist
		searchElm = $('.search-wrap')

		$scope.queue = jukePlayer.queue
		$scope.fxqueue = jukePlayer.fxqueue

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
				$('body').removeClass 'no'
		$(document).keypress (event) ->
				unless $('#q').is ':focus'
					searchElm.show()
					$('body').addClass 'no'
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