$(document).ready(function () {

    $('#ano').empty()
    $('#semestre').empty()
    $('#_center_id').empty()
    $('#_classroom_id').empty()
    $('#_course_id').empty()
    $('#_users_id').empty()
    $('#_subject_id').empty()
    $('#_campu_id').prepend("<option value='todos'>Todos</option>")
    $('#_campu_id option:first').attr("selected", "selected");
    $('#_center_id').prepend("<option value='todos'>Todos</option>")
    $('#_center_id option:first').attr("selected", "selected");
    $('#_course_id').prepend("<option value='todos'>Todos</option>")
    $('#_course_id option:first').attr("selected", "selected");
    $('#_subject_id').prepend("<option value='todos'>Todas</option>")
    $('#_subject_id option:first').attr("selected", "selected");
    $('#ano').prepend("<option value='todos'>Todos</option>")
    $('#ano option:first').attr("selected", "selected");
    $('#semestre').prepend("<option value='todos'>Todos</option>")
    $('#semestre option:first').attr("selected", "selected");
    $('#_classroom_id').prepend("<option value='todos'>Todas</option>")
    $('#_classroom_id option:first').attr("selected", "selected");
    $('#_users_id').prepend("<option value='todos'>Todos</option>")
    $('#_users_id option:first').attr("selected", "selected");

    $('#_center2_id').empty()
    $('#_classroom2_id').empty()
    $('#_course2_id').empty()
    $('#_users2_id').empty()
    $('#_subject2_id').empty()
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

    $('#_campu_id').change(function () {
      if($('#_campu_id').val() == 'todos'){
        $('#_center_id').empty()
        $('#_center_id').prepend("<option value='todos'>Todos</option>")
        $('#_center_id option:first').attr("selected", "selected");
        $('#_course_id').empty()
        $('#_course_id').prepend("<option value='todos'>Todos</option>")
        $('#_course_id option:first').attr("selected", "selected");
        $('#_subject_id').empty()
        $('#_subject_id').prepend("<option value='todos'>Todas</option>")
        $('#_subject_id option:first').attr("selected", "selected");
        $('#ano').empty()
        $('#ano').prepend("<option value='todos'>Todos</option>")
        $('#ano option:first').attr("selected", "selected");
        $('#semestre').empty()
        $('#semestre').prepend("<option value='todos'>Todos</option>")
        $('#semestre option:first').attr("selected", "selected");
        $('#_classroom_id').empty()
        $('#_classroom_id').prepend("<option value='todos'>Todas</option>")
        $('#_classroom_id option:first').attr("selected", "selected");
        $('#_users_id').empty()
        $('#_users_id').prepend("<option value='todos'>Todos</option>")
        $('#_users_id option:first').attr("selected", "selected");
      }
      $.ajax( {
        url: "/results/campu_selection",
        type: "GET",
        data: { campu : $('#_campu_id option:selected').val() },
      })
    })

    $('#_campu2_id').change(function () {
      if($('#_campu2_id').val() == 'todos'){
        $('#_center2_id').empty()
        $('#_center2_id').prepend("<option value='todos'>Todos</option>")
        $('#_center2_id option:first').attr("selected", "selected");
        $('#_course2_id').empty()
        $('#_course2_id').prepend("<option value='todos'>Todos</option>")
        $('#_course2_id option:first').attr("selected", "selected");
        $('#_subject2_id').empty()
        $('#_subject2_id').prepend("<option value='todos'>Todas</option>")
        $('#_subject2_id option:first').attr("selected", "selected");
        $('#_classroom2_id').empty()
        $('#_classroom2_id').prepend("<option value='todos'>Todas</option>")
        $('#_classroom2_id option:first').attr("selected", "selected");
        $('#_users2_id').empty()
        $('#_users2_id').prepend("<option value='todos'>Todos</option>")
        $('#_users2_id option:first').attr("selected", "selected");
      }
      $.ajax( {
        url: "/results/campu2_selection",
        type: "GET",
        data: { campu : $('#_campu2_id option:selected').val() },
      })
    })

    $('#_center_id').change(function () {
      if($('#_center_id').val() == 'todos'){
        $('#_course_id').empty()
        $('#_course_id').prepend("<option value='todos'>Todos</option>")
        $('#_course_id option:first').attr("selected", "selected");
        $('#_subject_id').empty()
        $('#_subject_id').prepend("<option value='todos'>Todas</option>")
        $('#_subject_id option:first').attr("selected", "selected");
        $('#ano').empty()
        $('#ano').prepend("<option value='todos'>Todos</option>")
        $('#ano option:first').attr("selected", "selected");
        $('#semestre').empty()
        $('#semestre').prepend("<option value='todos'>Todos</option>")
        $('#semestre option:first').attr("selected", "selected");
        $('#_classroom_id').empty()
        $('#_classroom_id').prepend("<option value='todos'>Todas</option>")
        $('#_classroom_id option:first').attr("selected", "selected");
        $('#_users_id').empty()
        $('#_users_id').prepend("<option value='todos'>Todos</option>")
        $('#_users_id option:first').attr("selected", "selected");
      }
      $.ajax( {
        url: "/results/center_selection",
        type: "GET",
        data: { center : $('#_center_id option:selected').val() },
      })
    })

    $('#_center2_id').change(function () {
      if($('#_center2_id').val() == 'todos'){
        $('#_course2_id').empty()
        $('#_course2_id').prepend("<option value='todos'>Todos</option>")
        $('#_course2_id option:first').attr("selected", "selected");
        $('#_subject2_id').empty()
        $('#_subject2_id').prepend("<option value='todos'>Todas</option>")
        $('#_subject2_id option:first').attr("selected", "selected");
        $('#_classroom2_id').empty()
        $('#_classroom2_id').prepend("<option value='todos'>Todas</option>")
        $('#_classroom2_id option:first').attr("selected", "selected");
        $('#_users2_id').empty()
        $('#_users2_id').prepend("<option value='todos'>Todos</option>")
        $('#_users2_id option:first').attr("selected", "selected");
      }
      $.ajax( {
        url: "/results/center2_selection",
        type: "GET",
        data: { center : $('#_center2_id option:selected').val() },
      })
    })

    $('#_course_id').change(function () {
      if($('#_course_id').val() == 'todos'){
        $('#_subject_id').empty()
        $('#_subject_id').prepend("<option value='todos'>Todas</option>")
        $('#_subject_id option:first').attr("selected", "selected");
        $('#ano').empty()
        $('#ano').prepend("<option value='todos'>Todos</option>")
        $('#ano option:first').attr("selected", "selected");
        $('#semestre').empty()
        $('#semestre').prepend("<option value='todos'>Todos</option>")
        $('#semestre option:first').attr("selected", "selected");
        $('#_classroom_id').empty()
        $('#_classroom_id').prepend("<option value='todos'>Todas</option>")
        $('#_classroom_id option:first').attr("selected", "selected");
        $('#_users_id').empty()
        $('#_users_id').prepend("<option value='todos'>Todos</option>")
        $('#_users_id option:first').attr("selected", "selected");
      }
      $.ajax( {
        url: "/results/course_selection",
        type: "GET",
        data: { course : $('#_course_id option:selected').val() },
      })
    })

    $('#_course2_id').change(function () {
      if($('#_course2_id').val() == 'todos'){
        $('#_subject2_id').empty()
        $('#_subject2_id').prepend("<option value='todos'>Todas</option>")
        $('#_subject2_id option:first').attr("selected", "selected");
        $('#_classroom2_id').empty()
        $('#_classroom2_id').prepend("<option value='todos'>Todas</option>")
        $('#_classroom2_id option:first').attr("selected", "selected");
        $('#_users2_id').empty()
        $('#_users2_id').prepend("<option value='todos'>Todos</option>")
        $('#_users2_id option:first').attr("selected", "selected");
      }
      $.ajax( {
        url: "/results/course2_selection",
        type: "GET",
        data: { course : $('#_course2_id option:selected').val() },
      })
    })

    $('#_subject_id').change(function () {
      if($('#_subject_id').val() == 'todos'){
        $('#ano').empty()
        $('#ano').prepend("<option value='todos'>Todos</option>")
        $('#ano option:first').attr("selected", "selected");
        $('#semestre').empty()
        $('#semestre').prepend("<option value='todos'>Todos</option>")
        $('#semestre option:first').attr("selected", "selected");
        $('#_classroom_id').empty()
        $('#_classroom_id').prepend("<option value='todos'>Todas</option>")
        $('#_classroom_id option:first').attr("selected", "selected");
        $('#_users_id').empty()
        $('#_users_id').prepend("<option value='todos'>Todos</option>")
        $('#_users_id option:first').attr("selected", "selected");
      }
      $.ajax( {
        url: "/results/subject_selection",
        type: "GET",
        data: { subject : $('#_subject_id option:selected').val() },
      })
    })

    $('#_subject2_id').change(function () {
      if($('#_subject2_id').val() == 'todos'){
        $('#_classroom2_id').empty()
        $('#_classroom2_id').prepend("<option value='todos'>Todas</option>")
        $('#_classroom2_id option:first').attr("selected", "selected");
        $('#_users2_id').empty()
        $('#_users2_id').prepend("<option value='todos'>Todos</option>")
        $('#_users2_id option:first').attr("selected", "selected");
      }
      $.ajax( {
        url: "/results/subject2_selection",
        type: "GET",
        data: { subject : $('#_subject2_id option:selected').val() },
      })
    })

    $('#ano').change(function () {
      if($('ano').val() == 'todos'){
        $('#semestre').empty()
        $('#semestre').prepend("<option value='todos'>Todos</option>")
        $('#semestre option:first').attr("selected", "selected");
        $('#_classroom_id').empty()
        $('#_classroom_id').prepend("<option value='todos'>Todas</option>")
        $('#_classroom_id option:first').attr("selected", "selected");
        $('#_users_id').empty()
        $('#_users_id').prepend("<option value='todos'>Todos</option>")
        $('#_users_id option:first').attr("selected", "selected");
      }
      $.ajax( {
        url: "/results/ano_selection",
        type: "GET",
        data: { ano : $('#ano option:selected').val(), subject : $('#_subject_id option:selected').val() },
      })
    })

    $('#_subject2_id').change(function () {
      if($('#_subject2_id').val() == 'todos'){
        $('#_classroom2_id').empty()
        $('#_classroom2_id').prepend("<option value='todos'>Todas</option>")
        $('#_classroom2_id option:first').attr("selected", "selected");
        $('#_users2_id').empty()
        $('#_users2_id').prepend("<option value='todos'>Todos</option>")
        $('#_users2_id option:first').attr("selected", "selected");
      }
      $.ajax( {
        url: "/results/subject2_selection",
        type: "GET",
        data: { subject : $('#_subject2_id option:selected').val() },
      })
    })

    $('#_classroom_id').change(function () {
      if($('#_classroom_id').val() == 'todos') {
        $('#_users_id').empty()
        $('#_users_id').prepend("<option value='todos'>Todos</option>")
        $('#_users_id option:first').attr("selected", "selected");
      }
      $.ajax( {
        url: "/results/classroom_selection",
        type: "GET",
        data: { classroom : $('#_classroom_id option:selected').val() },
      })
    })

    $('#_classroom2_id').change(function () {
      if($('#_classroom2_id').val() == 'todos') {
        $('#_users2_id').empty()
        $('#_users2_id').prepend("<option value='todos'>Todos</option>")
        $('#_users2_id option:first').attr("selected", "selected");
      }
      $.ajax( {
        url: "/results/classroom2_selection",
        type: "GET",
        data: { classroom : $('#_classroom2_id option:selected').val() },
      })
    })
});