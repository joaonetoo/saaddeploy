# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
    $('#alerts-value-4').children().hide()
    $('#recover input[type=radio]').on "change", ->
        value = $(this).val()
        name1 = $(this).attr('name')
        if ( value != "4")
            $(''+"#p"+name1+'').remove()

        if ( value == "4")
            $('#alerts-value-4').children().show()
            copy = $($(this).closest('tr'))
            copy1 = copy.children('tr td:nth-child(2)').text()

            $newli = $('
                <li class="list-warning" id="p' + name1 + '">
                  <i class=" fa fa-ellipsis-v"></i>
                  <div class="task-checkbox">
                    <input type="checkbox" name="extra' + name1 + '"/>
                  </div>
                  <div class="task-title">
                    <span class="task-title-sp"></span>
                  </div>
                </li>
            ')
            $('#sortable').append($newli)
            $newli.append(copy1)

    ###        $newp = $('<span class="task-title-sp"></span>').attr({id : ''+"p"+name1+''})
            $check = $('<input type="checkbox"/>').attr({name : ''+"extra"+name1+''})
            $('#extra').append($newp)
            $newp.append(copy1)
            $('#alerts-value-4-checkbox').append($check)
            $check.append($check)
    ###





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