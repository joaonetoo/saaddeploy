# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
    $('#extra').children().hide()
    $("input[type=checkbox]").on "change", ->
        if ($("input[type=checkbox]").prop('checked'))
            $('#extra').children().show()
        else
            $('#extra').children().hide()
    $('.note_div').hide()
    $('.add_button').on "click", ->
        $(".note_div").hide();
        $(".add_button").show();
        $(this).closest("div").find('.note_div').show()
        $(this).hide()
