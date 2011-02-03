/**
 * It seems IE can't display selectboxes that have a width set properly
 * 
 * @author	Tijs Verkoyen <tijs@sumocoders.be>
 */
// fix fault behaviour for selectboxes in IE
function fixSelectWidthForIE() {
	// only target IE
	if($.browser.msie)
	{
		// bind mousedown
		$('select:not([multiple])').mousedown(function()
		{
			// not already auto-width
			if($(this).css('width') != 'auto')
			{
				// get current width
				var width = $(this).width();

				// reset if needed
				if(typeof $(this).data('orginal-width') != 'undefined' && width > $(this).data('orginal-width')) width = $(this).data('orginal-width');

				// set data and new width
				$(this).data('orginal-width', width);
				$(this).css('width', 'auto');

				// if width is less then before, undo this
				if($(this).width() < width)
				{
					// unbind
					$(this).unbind('mousedown');

					// reset width
					$(this).css('width', $(this).data('orginal-width').toString() +'px');
				}
			}
		})

		// bind blur, if the user doesn't change the value
		.blur(function() {
			$(this).css('width', $(this).data('orginal-width').toString() +'px');
		})

		// bind change, if the user changes the value
		.change(function() {
			$(this).css('width', $(this).data('orginal-width').toString() +'px');
		});
    }
}

// call the function
fixSelectWidthForIE();