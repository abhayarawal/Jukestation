define 'grid', ['jquery'], ($) ->
	cols = 0
	offsetX = 0
	diag = 0

	options = 
	  width: 240
	  offsetX: 10
	  offsetY: 10
	  container: ".videos-grid"
	  card: ".card"

	diag = (options.width * (Math.sqrt 2))
	reset = ->
		cols = Math.floor(($(options.container).outerWidth() - (diag / 2) - options.offsetX) / (diag + options.offsetX))
		offsetX = Math.floor(($(options.container).outerWidth() - (diag / 2) - (((cols-1) * (diag + options.offsetX)) + diag)) / 2)

	setblocks = ->
		reset()
		leftpx = offsetX
		toppx = 80
		hc = true
		height = diag

		$('jk-video').each (i) ->
			$(@).css
				left: "#{leftpx + (diag / 8)}px"
				top: "#{toppx}px"
				margin: "0px"

			leftpx = diag + options.offsetX + leftpx
			if (i+1) % cols is 0
				leftpx = if hc then (options.offsetX / 2) + offsetX + (diag / 2) else offsetX
				toppx += ((diag / 2) + options.offsetY)
				hc = !hc
				# height += (diag + options.offsetY)
			# $(options.container).css
			# 	height: "#{height-190}px"
			return

	$(window).resize ->
		setblocks()
	setblocks()