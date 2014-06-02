## Snippet to distribute heights on items per row on multiple rows

highest = 0
arrayHeights = []
$items = $('.items')

# reset the height, so it can be recalculated
$items.height 'auto'

$items.each (index) -> # Loop over all items
  $item = $(@)
  highest = Math.max(highest, $item.outerHeight())
  arrayHeights.push $item # push all heights in array
  if (index + 1) % 'itemsPerRow' is 0 # check for the last item of the row
  # if $item.hasClass 'class' # check for the last item of the row

    # If we get to the last item, set all items with the height of the highest item
    j = 0

    while j < arrayHeights.length
      arrayHeights[j].height highest
      j++

    # Reset everything after last item
    arrayHeights = []
    highest = 0

  k = 0
  while k < arrayHeights.length # set height for last row
    arrayHeights[k].height highest
    k++

# End equal heights
