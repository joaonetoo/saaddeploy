# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
    $('#_campu_id').parent().hide()
    campus = $('#_campu_id').html()
    $('#_institution_id').on "change", ->
        institution = $('#_institution_id option:selected').text()
        options = $(campus).filter("optgroup[label='#{institution}']").html()
        if options
            $('#_campu_id').html(options)
            $('#_campu_id').parent().show()
        else
            $('#_campu_id').empty()