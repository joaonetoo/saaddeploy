# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
    $('#_campu_id').parent().hide()
    $('#_center_id').parent().hide()
    $('#_course_id').parent().hide()
    $('#_subject_id').parent().hide()
    $('#_classroom_id').parent().hide()
    $('#_users_id').parent().hide()
    campus = $('#_campu_id').html()
    centers = $('#_center_id').html()
    courses = $('#_course_id').html()
    subjects = $('#_subject_id').html()
    classrooms = $('#_classroom_id').html()
    users = $('#_users_id').html()

    $('#_institution_id').prepend("<option value='todos'>Todas</option>")
    $('#_institution_id option:first').attr("selected", "selected");
    $('#_campu_id').prepend("<option value='todos'>Todos</option>")
    $('#_campu_id option:first').attr("selected", "selected");
    $('#_center_id').prepend("<option value='todos'>Todos</option>")
    $('#_center_id option:first').attr("selected", "selected");
    $('#_course_id').prepend("<option value='todos'>Todos</option>")
    $('#_course_id option:first').attr("selected", "selected");
    $('#_subject_id').prepend("<option value='todos'>Todas</option>")
    $('#_subject_id option:first').attr("selected", "selected");
    $('#_classroom_id').prepend("<option value='todos'>Todas</option>")
    $('#_classroom_id option:first').attr("selected", "selected");
    $('#_users_id').prepend("<option value='todos'>Todos</option>")
    $('#_users_id option:first').attr("selected", "selected");

    $('#_institution_id').on "change", ->
        institution = $('#_institution_id option:selected').text()
        options = $(campus).filter("optgroup[label='#{institution}']").html()
        if options
            $('#_campu_id').html(options)
            $('#_campu_id').prepend("<option value='todos'>Todos</option>")
            $('#_campu_id option:first').attr("selected", "selected");
            $('#_campu_id').parent().show()
        else
            $('#_campu_id').empty()
            $('#_center_id').empty()
            $('#_course_id').empty()
            $('#_subject_id').empty()
            $('#_classroom_id').empty()
            $('#_users_id').empty()


    $('#_campu_id').on "change", ->
        campu = $('#_campu_id option:selected').text()
        options = $(centers).filter("optgroup[label='#{campu}']").html()
        if options
            $('#_center_id').html(options)
            $('#_center_id').prepend("<option value='todos'>Todos</option>")
            $('#_center_id option:first').attr("selected", "selected");
            $('#_center_id').parent().show()
        else
            $('#_center_id').empty()
            $('#_course_id').empty()
            $('#_subject_id').empty()
            $('#_classroom_id').empty()
            $('#_users_id').empty()

    $('#_center_id').on "change", ->
        center = $('#_center_id option:selected').text()
        options = $(courses).filter("optgroup[label='#{center}']").html()
        if options
            $('#_course_id').html(options)
            $('#_course_id').prepend("<option value='todos'>Todos</option>")
            $('#_course_id option:first').attr("selected", "selected");
            $('#_course_id').parent().show()
        else
            $('#_course_id').empty()
            $('#_subject_id').empty()
            $('#_classroom_id').empty()
            $('#_users_id').empty()

    $('#_course_id').on "change", ->
        course = $('#_course_id option:selected').text()
        options = $(subjects).filter("optgroup[label='#{course}']").html()
        if options
            $('#_subject_id').html(options)
            $('#_subject_id').prepend("<option value='todos'>Todas</option>")
            $('#_subject_id option:first').attr("selected", "selected");
            $('#_subject_id').parent().show()
        else
            $('#_subject_id').empty()
            $('#_classroom_id').empty()
            $('#_users_id').empty()

    $('#_subject_id').on "change", ->
        subject = $('#_subject_id option:selected').text()
        options = $(classrooms).filter("optgroup[label='#{subject}']").html()
        if options
            $('#_classroom_id').html(options)
            $('#_classroom_id').prepend("<option value='todos'>Todas</option>")
            $('#_classroom_id option:first').attr("selected", "selected");
            $('#_classroom_id').parent().show()
        else
            $('#_classroom_id').empty()
            $('#_users_id').empty()

      $('#_classroom_id').on "change", ->
        classroom = $('#_classroom_id option:selected').text()
        options = $(users).filter("optgroup[label='#{classroom}']").html()
        if options
            $('#_users_id').html(options)
            $('#_users_id').prepend("<option value='todos'>Todos</option>")
            $('#_users_id option:first').attr("selected", "selected");
            $('#_users_id').parent().show()
        else
            $('#_user_id').empty()