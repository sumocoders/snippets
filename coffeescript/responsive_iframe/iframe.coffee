# This snippet can be used to make a video fit to the wrapper div width
# Very useful for Vimeo of Youtube embeds

###
Must be used with
  - jQuery
###

$('iframe').each ->
  $iframe = $(@)
  $wrap = $(@).parent()
  width = $iframe.attr('width')
  height = $iframe.attr('height')
  constraint = height / width
  $iframe.removeAttr('width').removeAttr('height').width($wrap.width()).height($wrap.width() * constraint)
