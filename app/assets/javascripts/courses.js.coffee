# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
    $('#subject_course_id').autocomplete
        source: $('#subject_course_id').data('autocomplete-source')