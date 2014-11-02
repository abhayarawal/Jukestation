define 'jkDr', ['angular'], (ng) ->
	jkDr = ng.module 'Jukestation.jkDr', []

	jkDr.directive 'jkVideo', ->
		restrict: 'E'
		scope: 
			video: "="
		template: """
			<div class="card">
				{{ video.title }}
			</div>
		"""

	jkDr