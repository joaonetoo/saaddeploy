# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
    $('#course_institution_id').autocomplete
        source: $('#course_institution_id').data('autocomplete-source')