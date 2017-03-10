# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#close').on "click", (event) ->
    event.preventDefault()
    $('#close').hide()
    $('#form').fadeOut()