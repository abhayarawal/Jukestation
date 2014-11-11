define 'grid', ['jquery'], ($) ->
	cols = 0
	offsetX = 0

	options = 
	  width: 445
	  offsetX: 25
	  offsetY: 25
	  container: ".videos-grid"
	  card: ".card"

	grid =
		hidestate: false
		reset: ->
			cols = Math.floor(($(options.container).outerWidth()) / (options.width + options.offsetX))
			offsetX = Math.floor(($(options.container).outerWidth() - ((cols-1) * (options.width + options.offsetX) + options.width)) / 2)

		togglegrid: () ->
			if @.hidestate
				@.hidestate = false
				@.setblocks()
			else
				@.hidestate = true
				$('jk-video').each (i) ->
					$(@).css
						left: "-445px"
						top: "0px"
				.promise().done ->
					setTimeout ->
						$(options.container).css height: "150px"
					, 500
			return false

		setblocks: ->
			unless @.hidestate
				@.reset()
				leftpx = offsetX
				toppx = 0
				height = 0

				$('jk-video').each (i) ->
					height += 1
					$(@).css
						left: "#{leftpx}px"
						top: "#{toppx}px"
						margin: "0px"

					leftpx = leftpx + options.width + options.offsetX
					if (i+1) % cols is 0
						leftpx = offsetX
						toppx = toppx + 150 + options.offsetY
				height = Math.ceil height/cols
				$(options.container).css
					height: "#{(150*height)+(height*options.offsetY)}px"
				return

	$(window).resize ->
		grid.setblocks()
	grid