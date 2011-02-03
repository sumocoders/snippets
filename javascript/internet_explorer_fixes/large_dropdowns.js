/**
 * It seems IE can't display selectboxes that have a width set properly
 * 
 * When the select is entered the width wil be reset to auto, the original width will be stored, so if the mouse 
 * leaves the select the width wil be restored
 */
$('.ie7 select').mouseenter(function() { $(this).data('original-width', $(this).width()).css('width', 'auto'); });
$('.ie7 select').mouseout(function () { $(this).css('width', $(this).data('original-width') +'px'); });