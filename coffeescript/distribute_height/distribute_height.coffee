## Snippet to distribute heights on a couple of elements

# the wrap
$wrap = $('[data-distribute-height]')

# we want each wrap seperate
$wrap.each ->
  maxHeight = 0
  $items = $(this).find '.item'

  # reset the height, so it can be recalculated
  $items.height 'auto'

  # check the height of each item, if it's bigger that the highest at that point, overwrite the maxHeight
  $items.each ->
    height = $(this).height()

    if height > maxHeight
      maxHeight = height

    # set the height for all items
    $items.height maxHeight
