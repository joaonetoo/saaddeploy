jQuery ->
    $('#user_course_id').parent().hide()
    courses = $('#user_course_id').html()
    $('#user_institution_id').on "change", ->
        institution = $('#user_institution_id option:selected').text()
        options = $(courses).filter("optgroup[label='#{institution}']").html()
        if options
            $('#user_course_id').html(options)
            $('#user_course_id').parent().show()
        else
            $('#user_course_id').empty()
