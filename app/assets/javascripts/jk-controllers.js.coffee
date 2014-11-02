define 'jkControllers', ['angular', 'jkFactories', 'grid'], (ng, jkFactories, grid) ->
	jkControllers = ng.module 'Jukestation.jkControllers', ['Jukestation.jkFactories']

	jkControllers.controller 'jukeController', ['$scope', 'jukePlayer', ($scope, jukePlayer) ->
		jukePlayer.init()
		$scope.playlist = jukePlayer.playlist

		$scope.remove = (entry) ->
			jukePlayer.remove(entry)

		$scope.sync = ->
			jukePlayer.sync()
	]

	jkControllers.directive 'repeatEdge', ->
		((scope, element, attrs)->
			grid() if scope.$last
		)

	jkControllers.controller 'ytsController', ['$scope', 'jkSearch', 'jukePlayer', ($scope, jkSearch, jukePlayer) ->
		$scope.$watch 'query', (q) ->
			defer = jkSearch.fetch_yt_videos q
			defer.promise.then (d) ->
				$scope.ytvideos = d

		$scope.enqueue = (entry) ->
			jukePlayer.enqueue entry
	]

	jkControllers