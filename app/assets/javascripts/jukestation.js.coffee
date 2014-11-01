define 'jukestation', ['angular', 'jkDr', 'jkControllers'], (ng, jkDr, jkControllers) ->
	Jukestation = ng.module 'Jukestation', [
		'Jukestation.jkDr',
		'Jukestation.jkControllers'
	]

	# Initialize application
	Jukestation.init = ->
		$html = ng.element document.getElementsByTagName('html')[0]
		
		ng.element().ready ->
	  	ng.bootstrap document, ['Jukestation']

	Jukestation