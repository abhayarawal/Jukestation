define 'jkFactories', ['angular'], (ng) ->
	jkFactories = ng.module 'Jukestation.jkFactories', []

	jkFactories.factory 'jkSearch', ['$http', '$q', ($http, $q) ->
		fetch_yt_videos: (query) ->
			api = "https://gdata.youtube.com/feeds/api/videos?category=Music"
			options = 
				q: query
				'max-results': 12
				alt: 'json'
			ret = $q.defer()
			$http.get(api, params: options
			).success (videos) ->
				ret.resolve videos.feed.entry

			# Return the videos
			ret
	]

	jkFactories