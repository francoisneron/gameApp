idleTime = 0

timerIncrement = ->
  idleTime = idleTime + 1
  if idleTime > 60
    console.log 'idle'
    Router.go('/idle')
  return

$(document).ready ->
  #Increment the idle time counter every minute.
  idleInterval = setInterval(timerIncrement, 1000)
  # 1 seconds
  #Zero the idle timer on mouse movement.
  $(this).mousemove (e) ->
    idleTime = 0
  $(this).keypress (e) ->
    idleTime = 0
  
  return

Meteor.startup ->
	Session.set 'level', KID
	Session.set 'thumbRoot', Meteor.settings.public.thumb_root
	Session.set 'imageRoot', Meteor.settings.public.image_root
