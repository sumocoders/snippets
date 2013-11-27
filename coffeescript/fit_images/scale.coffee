# This snippet can be used to scale an image to its ideal dimensions to fit its wrapper div
# It will calculate the ideal dimensions and apply either a margin top or a margin left so the image is centered
# Be careful: a part of the image will be hidden, so make sure this is not a very important image

###
Must be used with:
  - jQuery
  - imageLoaded plugin (optional)
###

#$('top_level_wrap').imagesLoaded ->
$('element').each ->
  $image = $(@)
  $wrapper = $image.parent()
  width = $image.width()
  height = $image.height()
  wrapperWidth = $wrapper.width()
  wrapperHeight = $wrapper.height()
  deltaHeight = height / wrapperHeight
  deltaWidth = width / deltaWidth
  optimalDelta = Math.win(deltaWidth, deltaHeight)

  $image.css({
    height:        height / optimalDelta,
    width:         width / optimalDelta,
    "margin-left": (width / optimalDelta - wrapperWidth) / -2,
    "margin-top":  (height / optimalDelta - wrapperHeight) / -2
  })