define 'jkDr', ['angular'], (ng) ->
	jkDr = ng.module 'Jukestation.jkDr', []

	jkDr.directive 'jkVideo', ->
		restrict: 'E'
		scope: 
			video: "="
		template: """
			<div class="card">
				All time low - Time bomb
			</div>
		"""

	jkDr