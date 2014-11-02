define 'jukestation', ['angular', 'jkDr', 'jkControllers', 'jkFilters'], (ng, jkDr, jkControllers, jkFilters) ->
	Jukestation = ng.module 'Jukestation', [
		'Jukestation.jkDr',
		'Jukestation.jkControllers',
		'Jukestation.jkFilters'
	]

	# Initialize application
	Jukestation.init = ->
		$html = ng.element document.getElementsByTagName('html')[0]
		
		ng.element().ready ->
	  	ng.bootstrap document, ['Jukestation']

	Jukestation