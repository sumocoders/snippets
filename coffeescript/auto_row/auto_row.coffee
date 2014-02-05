# This snippet is used to wrap a certain amount of items in a wrapper div. Ideal to automatically wrap cols in rows

# Selector for the divs
divs = $('.col-sm-3')
i = 0
while i < divs.length
  divs.slice(i, i+3).wrapAll('<div class="item"></div>')
  i += 3
