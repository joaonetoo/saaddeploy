jQuery ->
    classrooms = $('#_classroom_id').html()
    classrooms2 = $('#_classroom_id').html()

    users = $('#_users_id').html()
    users2 = $('#_users2_id').html()


    $('#_subject_id').prepend("<option value='todos'>Todas</option>")
    $('#_subject_id option:first').attr("selected", "selected");
    $('#_classroom_id').empty()
    $('#_classroom_id').prepend("<option value='todos'>Todas</option>")
    $('#_classroom_id option:first').attr("selected", "selected");
    $('#_users_id').empty()
    $('#_users_id').prepend("<option value='todos'>Todos</option>")
    $('#_users_id option:first').attr("selected", "selected");

    $('#_subject2_id').prepend("<option value='todos'>Todas</option>")
    $('#_subject2_id option:first').attr("selected", "selected");
    $('#_classroom2_id').empty()
    $('#_classroom2_id').prepend("<option value='todos'>Todas</option>")
    $('#_classroom2_id option:first').attr("selected", "selected");
    $('#_users2_id').empty()
    $('#_users2_id').prepend("<option value='todos'>Todos</option>")
    $('#_users2_id option:first').attr("selected", "selected");

    $('#_subject_id').on "change", ->
        subject = $('#_subject_id option:selected').text()
        options = $(classrooms).filter("optgroup[label='#{subject}']").html()
        if options
            $('#_classroom_id').html(options)
            $('#_classroom_id').prepend("<option value='todos'>Todas</option>")
            $('#_classroom_id option:first').attr("selected", "selected");
            $('#_classroom_id').parent().show()
        else
            $('#_users_id').empty()
            $('#_users_id').prepend("<option value='todos'>Todos</option>")
            $('#_users_id option:first').attr("selected", "selected")
            $('#_classroom_id').empty()
            $('#_classroom_id').prepend("<option value='todos'>Todas</option>")
            $('#_classroom_id option:first').attr("selected", "selected");


    $('#_subject2_id').on "change", ->
        subject2 = $('#_subject2_id option:selected').text()
        options2 = $(classrooms2).filter("optgroup[label='#{subject2}']").html()
        if options2
            $('#_classroom2_id').html(options)
            $('#_classroom2_id').prepend("<option value='todos'>Todas</option>")
            $('#_classroom2_id option:first').attr("selected", "selected")
            $('#_classroom2_id').parent().show()
        else
            $('#_users2_id').empty()
            $('#_users2_id').prepend("<option value='todos'>Todos</option>")
            $('#_users2_id option:first').attr("selected", "selected")
            $('#_classroom2_id').empty()
            $('#_classroom2_id').prepend("<option value='todos'>Todas</option>")
            $('#_classroom2_id option:first').attr("selected", "selected");


    $('#_classroom_id').on "change", ->
        classroom = $('#_classroom_id option:selected').text()
        options = $(users).filter("optgroup[label='#{classroom}']").html()
        if options
            $('#_users_id').html(options)
            $('#_users_id').prepend("<option value='todos'>Todos</option>")
            $('#_users_id option:first').attr("selected", "selected");
            $('#_users_id').parent().show()
        else
            $('#_users_id').empty()
            $('#_users_id').prepend("<option value='todos'>Todos</option>")
            $('#_users_id option:first').attr("selected", "selected");

    $('#_classroom2_id').on "change", ->
        classroom2 = $('#_classroom2_id option:selected').text()
        options2 = $(users2).filter("optgroup[label='#{classroom2}']").html()
        if options2
            $('#_users2_id').html(options2)
            $('#_users2_id').prepend("<option value='todos'>Todos</option>")
            $('#_users2_id option:first').attr("selected", "selected");
            $('#_users2_id').parent().show()
        else
            $('#_users2_id').empty()
            $('#_users2_id').prepend("<option value='todos'>Todos</option>")
            $('#_users2_id option:first').attr("selected", "selected");


