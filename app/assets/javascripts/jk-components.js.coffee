define 'jkDr', ['angular'], (ng) ->
	jkDr = ng.module 'Jukestation.jkDr', []

	jkDr.directive 'jkVideo', ->
		restrict: 'E'
		scope: 
			video: "="
			remove: "&"
		template: """
		<div class="flip-container" ontouchstart="this.classList.toggle('hover');">
			<div class="flipper">
				<div class="front">
					<div class="card">
						<div class="thumbnail">
							<img src="{{ video.thumbnail }}" alt="">
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
						<button class="button icon-layers"></button>
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
				console.log "qq"
		template: """
			<div class="thumbnail">
				<img src="{{ video.thumbnail }}" alt="">
			</div>
			<h3>{{ video.title }}</h3>
			<a ng-click="add()">Add</a>
		"""

	jkDr