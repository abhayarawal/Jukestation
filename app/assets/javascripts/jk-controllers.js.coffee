define 'jkControllers', ['angular', 'jkFactories'], (ng, jkFactories) ->
	jkControllers = ng.module 'Jukestation.jkControllers', ['Jukestation.jkFactories']

	jkControllers.controller 'jukeController', ['$scope', 'Video', 'jukePlayer', ($scope, Video, jukePlayer) ->
		# videos = Video.get vid: "hkasl"
		# videos.$promise.then (d) ->
		# 	console.log d.uri

		jukePlayer.init()
		$scope.playlist = jukePlayer.playlist

		$scope.remove = (entry) ->
			jukePlayer.remove(entry)
			
		$scope.sync = ->
			jukePlayer.sync()
	]

	jkControllers.controller 'ytsController', ['$scope', 'jkSearch', 'jukePlayer', ($scope, jkSearch, jukePlayer) ->
		$scope.$watch 'query', (q) ->
			defer = jkSearch.fetch_yt_videos q
			defer.promise.then (d) ->
				$scope.ytvideos = d

		$scope.enqueue = (entry) ->
			jukePlayer.enqueue entry
	]

	jkControllers