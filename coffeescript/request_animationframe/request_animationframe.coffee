# This is a snippet for a requestanimationframe, very useful to fire function on scroll or on window resize

function: ->

  ticking = false

  # this will be put in animationFrame
  calculate = ->

    # Make your calculations here

    ticking = false

  tick = ->
    if !ticking
      @requestAnimationFrame(calculate)
      ticking = true

  tick()

  $(window).on 'resize', ->
    tick()
