define 'grid', ['jquery'], ($) ->
	cols = 0
	offsetX = 0

	options = 
	  width: 450
	  offsetX: 25
	  offsetY: 25
	  container: ".videos-grid"
	  card: ".card"

	reset = ->
		cols = Math.floor(($(options.container).outerWidth()) / (options.width + options.offsetX))
		offsetX = Math.floor(($(options.container).outerWidth() - ((cols-1) * (options.width + options.offsetX) + options.width)) / 2)

	setblocks = ->
		reset()
		leftpx = offsetX
		toppx = 0
		height = 0

		$('jk-video').each (i) ->
			$(@).css
				left: "#{leftpx}px"
				top: "#{toppx}px"
				margin: "0px"

			leftpx = leftpx + options.width + options.offsetX
			if (i+1) % cols is 0
				leftpx = offsetX
				toppx = toppx + 150 + options.offsetY
				height += (150 + options.offsetY)
			$(options.container).css
				height: "#{height+150}px"
			return

	$(window).resize ->
		setblocks()
	setblocks