# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
    $('#extra').children().hide()
    $('#recover input[type=radio]').on "change", ->
        value = $(this).val()
        if ( value == "4")
            $('#extra').children().show()
            $('#extra').append("<p>Test</p>")

    $('form').submit ->
        count = 0
        $('#recover input[type=radio]').each ->
            if ($(this).prop('checked'))
                count = count + 1
        if (count == 40)
            complete = true
        else
            alert((40 - count) + " Questões sem marcar")
            $('#notice').html((40 - count) + " Questões sem marcar")
            return false
    if (complete == true)
        return true