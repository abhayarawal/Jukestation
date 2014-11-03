define 'jkDr', ['angular'], (ng) ->
	jkDr = ng.module 'Jukestation.jkDr', []

	jkDr.directive 'jkVideo', ->
		restrict: 'E'
		scope: 
			video: "="
			remove: "&"
			pushfxq: "&"
			undo: "&"
		template: """
		<div class="flip-container" ontouchstart="this.classList.toggle('hover');" ng-class="{deleted:video.deleted}">
			<button class="undo button icon-reload" ng-click="undo()" ng-show="video.deleted"></button>
			<div class="flipper">
				<div class="front">
					<div class="card">
						<div class="thumbnail">
							<img ng-src="{{ video.thumbnail }}" alt="">
						</div>
						<div class="meta">
							<span class="duration">{{ video.duration | duration }}</span>
							<h3>{{ video.title }}</h3>
						</div>
					</div>
				</div>
				<div class="back">
					<div class="card-ctl">
						<button class="button icon-play"></button>
						<button class="button icon-trash" ng-click="remove()"></button>
						<button class="button icon-layers" ng-click="pushfxq()"></button>
					</div>
				</div>
			</div>
		</div>
		"""

	jkDr.directive 'ytVideo', ->
		restrict: 'E'
		scope: 
			video: "="
			add: "&"
		link: (scope, element, attrs) ->
			scope.queue = ->
				scope.add()
				scope.video.inqueue = true
		template: """
			<div class="thumbnail">
				<img ng-src="{{ video.thumbnail }}" alt="">
				<button class="button icon-plus type2" ng-hide="video.inqueue" ng-click="queue()"></button>
				<span class="button icon-check type3" ng-show="video.inqueue"></span>
			</div>
			<h3>{{ video.title }}</h3>
		"""

	jkDr