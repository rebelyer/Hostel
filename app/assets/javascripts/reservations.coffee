# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
   $('.input-daterange').datepicker(
      weekStart: 1
      format: "dd/mm/yyyy"
   )
   $('input:hidden[name="reservation[discount]"]').val(0.0)

$(document).ready(ready)
$(document).on('page:load', ready)
