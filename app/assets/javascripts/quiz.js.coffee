# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
    $('form').submit ->
        count = 0
        $('#recover input[type=radio]').each ->
            if ($(this).prop('checked'))
                count = count + 1
        if (count == 40)
            return true
        else
            alert((40 - count) + " Questões sem marcar")
            $('#notice').html((40 - count) + " Questões sem marcar")
            return false