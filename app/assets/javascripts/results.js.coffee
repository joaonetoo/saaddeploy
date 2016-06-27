# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->

    campus = $('#_campu_id').html()
    centers = $('#_center_id').html()
    courses = $('#_course_id').html()
    subjects = $('#_subject_id').html()
    classrooms = $('#_classroom_id').html()
    users = $('#_users_id').html()

    campus2 = $('#_campu2_id').html()
    centers2 = $('#_center2_id').html()
    courses2 = $('#_course2_id').html()
    subjects2 = $('#_subject2_id').html()
    classrooms2 = $('#_classroom2_id').html()
    users2 = $('#_users2_id').html()

    $('#_campu_id').empty()
    $('#_center_id').empty()
    $('#_course_id').empty()
    $('#_subject_id').empty()
    $('#_classroom_id').empty()
    $('#_users_id').empty()

    $('#_campu2_id').empty()
    $('#_center2_id').empty()
    $('#_course2_id').empty()
    $('#_subject2_id').empty()
    $('#_classroom2_id').empty()
    $('#_users2_id').empty()


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

    $('#_institution2_id').prepend("<option value='todos'>Todas</option>")
    $('#_institution2_id option:first').attr("selected", "selected");
    $('#_campu2_id').prepend("<option value='todos'>Todos</option>")
    $('#_campu2_id option:first').attr("selected", "selected");
    $('#_center2_id').prepend("<option value='todos'>Todos</option>")
    $('#_center2_id option:first').attr("selected", "selected");
    $('#_course2_id').prepend("<option value='todos'>Todos</option>")
    $('#_course2_id option:first').attr("selected", "selected");
    $('#_subject2_id').prepend("<option value='todos'>Todas</option>")
    $('#_subject2_id option:first').attr("selected", "selected");
    $('#_classroom2_id').prepend("<option value='todos'>Todas</option>")
    $('#_classroom2_id option:first').attr("selected", "selected");
    $('#_users2_id').prepend("<option value='todos'>Todos</option>")
    $('#_users2_id option:first').attr("selected", "selected");

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
            $('#_users_id').empty()


    $('#_institution2_id').on "change", ->
        institution2 = $('#_institution2_id option:selected').text()
        options2 = $(campus2).filter("optgroup[label='#{institution2}']").html()
        if options2
            $('#_campu2_id').html(options2)
            $('#_campu2_id').prepend("<option value='todos'>Todos</option>")
            $('#_campu2_id option:first').attr("selected", "selected");
            $('#_campu2_id').parent().show()
        else
            $('#_campu2_id').empty()
            $('#_center2_id').empty()
            $('#_course2_id').empty()
            $('#_subject2_id').empty()
            $('#_classroom2_id').empty()
            $('#_users2_id').empty()


    $('#_campu2_id').on "change", ->
        campu2 = $('#_campu2_id option:selected').text()
        options2 = $(centers2).filter("optgroup[label='#{campu2}']").html()
        if options2
            $('#_center2_id').html(options2)
            $('#_center2_id').prepend("<option value='todos'>Todos</option>")
            $('#_center2_id option:first').attr("selected", "selected");
            $('#_center2_id').parent().show()
        else
            $('#_center2_id').empty()
            $('#_course2_id').empty()
            $('#_subject2_id').empty()
            $('#_classroom2_id').empty()
            $('#_users2_id').empty()

    $('#_center2_id').on "change", ->
        center2 = $('#_center2_id option:selected').text()
        options2 = $(courses2).filter("optgroup[label='#{center2}']").html()
        if options2
            $('#_course2_id').html(options2)
            $('#_course2_id').prepend("<option value='todos'>Todos</option>")
            $('#_course2_id option:first').attr("selected", "selected");
            $('#_course2_id').parent().show()
        else
            $('#_course2_id').empty()
            $('#_subject2_id').empty()
            $('#_classroom2_id').empty()
            $('#_users2_id').empty()

    $('#_course2_id').on "change", ->
        course2 = $('#_course2_id option:selected').text()
        options2 = $(subjects2).filter("optgroup[label='#{course2}']").html()
        if options2
            $('#_subject2_id').html(options2)
            $('#_subject2_id').prepend("<option value='todos'>Todas</option>")
            $('#_subject2_id option:first').attr("selected", "selected");
            $('#_subject2_id').parent().show()
        else
            $('#_subject2_id').empty()
            $('#_classroom2_id').empty()
            $('#_users2_id').empty()

    $('#_subject2_id').on "change", ->
        subject2 = $('#_subject2_id option:selected').text()
        options2 = $(classrooms2).filter("optgroup[label='#{subject2}']").html()
        if options2
            $('#_classroom2_id').html(options2)
            $('#_classroom2_id').prepend("<option value='todos'>Todas</option>")
            $('#_classroom2_id option:first').attr("selected", "selected");
            $('#_classroom2_id').parent().show()
        else
            $('#_classroom2_id').empty()
            $('#_users2_id').empty()

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