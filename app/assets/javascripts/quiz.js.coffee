# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
    $('#extra').children().hide()
    $('#recover input[type=radio]').on "change", ->
        value = $(this).val()
        name1 = $(this).attr('name')
        if ( value != "4")
            $(''+"#p"+name1+'').remove()

        if ( value == "4")
            $('#extra').children().show()
            copy = $($(this).closest('p'))
            copy1 = copy.children('strong').text()
            $newp = $('<p></p>').attr({id : ''+"p"+name1+''})
            $check = $('<input type="checkbox"/>').attr({name : ''+"extra"+name1+''})
            $('#extra').append($newp)
            $newp.append(copy1)
            $newp.append($check)
            $newp.append("<br>")


    $('#myform').submit ->
        count = 0
        countcheck = 0
        $('#recover input[type=radio]').each ->
            if ($(this).prop('checked'))
                count = count + 1
        $('#extra input[type=checkbox]').each ->
            if ($(this).prop('checked'))
                countcheck = countcheck + 1

        if (count == 40 && countcheck == 5)
            complete = true
        else
            if(countcheck < 5)
                alert((5 - countcheck) + " questoes extras sem pontuar")
            else if(countcheck > 5)
                alert("Pontue apenas 5 questões extras")
            $('#notice').html((40 - count) + " Questões sem marcar")
            return false
    if (complete == true)
        return true