define 'jkFilters', ['angular'], (ng) ->
	jkFilter = ng.module 'Jukestation.jkFilters', []

	jkFilter.filter 'duration', ->
		((item) ->
			m = Math.floor item / 60
			"#{m}:#{item-(m * 60)}"
		)

	jkFilter