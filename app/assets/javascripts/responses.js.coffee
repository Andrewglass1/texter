# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->

  $('#use-button').hover ->
    hideAll()
    $('#use-content').show()

  $('#text-button').hover ->
    hideAll()
    $('#text-content').show()

  $('#contact-button').hover ->
    hideAll()
    $('#contact-content').show()


  hideAll = () ->
    $('#use-content').hide()
    $('#main-content').hide()
    $('#text-content').hide()
    $('#contact-content').hide()


