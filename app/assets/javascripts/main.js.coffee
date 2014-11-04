require.config
	paths:
		jquery: '//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min'
		angular: '//ajax.googleapis.com/ajax/libs/angularjs/1.3.1/angular.min'
		angularResource: '//code.angularjs.org/1.3.1/angular-resource.min'
		jukestation: '/assets/jukestation.js'
		jkFilters: '/assets/jk-filters.js'
		jkFactories: '/assets/jk-factories.js'
		jkDr: '/assets/jk-components.js'
		jkControllers: '/assets/jk-controllers.js'
		grid: '/assets/grid.js'
		underscore: '//cdnjs.cloudflare.com/ajax/libs/underscore.js/1.7.0/underscore-min'
		scroll: '/assets/scroll.min'

	shim:
    angular:
      deps: ['jquery']
      exports: 'angular'
    angularResource:
      deps: ['angular']
      exports: 'angularResource'
    scroll:
    	deps: ['jquery']


require ['jukestation', 'scroll'], (jukestation, scroll) ->
	jukestation.init()

	$('.search-wrap').mCustomScrollbar
		theme: "dark-2"
		scrollInertia: 300

	$('.sc-mid').mCustomScrollbar
		theme: "light-2"
		scrollInertia: 300
