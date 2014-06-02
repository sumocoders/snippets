# This is a snippet for a requestanimationframe, very useful to fire function on scroll or on window resize

# Request AnimationFrame Polyfill

window.requestAnimationFrame = (->
  lastTime = 0

  window.requestAnimationFrame ||
  window.webkitRequestAnimationFrame ||
  window.mozRequestAnimationFrame ||
  window.oRequestAnimationFrame ||
  window.msRequestAnimationFrame ||
  (callback, element) ->
    curTime = new Date().getTime()
    timeToCall = Math.max(0, 16 - (curTime - lastTime))
    id = window.setTimeout(
      -> callback(curTime + timeToCall)
    , timeToCall)
    lastTime = curTime + timeToCall
    return id
)()


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
