require.config
	paths:
		jquery: '//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min'
		angular: '//ajax.googleapis.com/ajax/libs/angularjs/1.2.23/angular.min'
		jukestation: '/assets/jukestation.js'
		jkFactories: '/assets/jk-factories.js'
		jkDr: '/assets/jk-components.js'
		jkControllers: '/assets/jk-controllers.js'
		grid: '/assets/grid.js'

	shim:
    angular:
      deps: ['jquery']
      exports: 'angular'


require ['jukestation', 'grid'], (jukestation, grid) ->
	jukestation.init()