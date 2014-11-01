define 'jkControllers', ['angular', 'jkFactories', 'jkDr'], (ng, jkFactories, jkDr) ->
	jkControllers = ng.module 'Jukestation.jkControllers', ['Jukestation.jkFactories']

	jkControllers.controller 'ytsController', ['$scope', 'jkSearch', ($scope, jkSearch) ->
		$scope.$watch 'query', (q) ->
			defer = jkSearch.fetch_yt_videos q
			defer.promise.then (d) ->
				$scope.ytvideos = d
	]

	jkControllers