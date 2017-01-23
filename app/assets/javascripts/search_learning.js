$(document).ready(function () {

    $('#ano').empty()
    $('#semestre').empty()
    $('#_classroom_id').empty()
    $('#_users_id').empty()
    $('#_subject_id').prepend("<option value='todos'>Todas</option>")
    $('#_subject_id option:first').attr("selected", "selected");
    $('#_classroom_id').prepend("<option value='todos'>Todas</option>")
    $('#_classroom_id option:first').attr("selected", "selected");
    $('#_users_id').prepend("<option value='todos'>Todos</option>")
    $('#_users_id option:first').attr("selected", "selected");
    $('#ano').prepend("<option value='todos'>Todos</option>")
    $('#ano option:first').attr("selected", "selected");
    $('#semestre').prepend("<option value='todos'>Todos</option>")
    $('#semestre option:first').attr("selected", "selected");

    $('#ano2').empty()
    $('#semestre2').empty()
    $('#_classroom2_id').empty()
    $('#_users2_id').empty()
    $('#_subject2_id').prepend("<option value='todos'>Todas</option>")
    $('#_subject2_id option:first').attr("selected", "selected");
    $('#_classroom2_id').prepend("<option value='todos'>Todas</option>")
    $('#_classroom2_id option:first').attr("selected", "selected");
    $('#_users2_id').prepend("<option value='todos'>Todos</option>")
    $('#_users2_id option:first').attr("selected", "selected");
    $('#ano2').prepend("<option value='todos'>Todos</option>")
    $('#ano2 option:first').attr("selected", "selected");
    $('#semestre2').prepend("<option value='todos'>Todos</option>")
    $('#semestre2 option:first').attr("selected", "selected");

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
        $('#ano2').empty()
        $('#ano2').prepend("<option value='todos'>Todos</option>")
        $('#ano2 option:first').attr("selected", "selected");
        $('#semestre2').empty()
        $('#semestre2').prepend("<option value='todos'>Todos</option>")
        $('#semestre2 option:first').attr("selected", "selected");
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

    $('#ano2').change(function () {
      if($('ano2').val() == 'todos'){
        $('#semestre2').empty()
        $('#semestre2').prepend("<option value='todos'>Todos</option>")
        $('#semestre2 option:first').attr("selected", "selected");
        $('#_classroom2_id').empty()
        $('#_classroom2_id').prepend("<option value='todos'>Todas</option>")
        $('#_classroom2_id option:first').attr("selected", "selected");
        $('#_users2_id').empty()
        $('#_users2_id').prepend("<option value='todos'>Todos</option>")
        $('#_users2_id option:first').attr("selected", "selected");
      }
      $.ajax( {
        url: "/results/ano2_selection",
        type: "GET",
        data: { ano : $('#ano2 option:selected').val(), subject : $('#_subject2_id option:selected').val() },
      })
    })

    $('#semestre').change(function () {
      if($('semestre').val() == 'todos'){
        $('#_classroom_id').empty()
        $('#_classroom_id').prepend("<option value='todos'>Todos</option>")
        $('#_classroom_id option:first').attr("selected", "selected");
        $('#_users_id').empty()
        $('#_users_id').prepend("<option value='todos'>Todas</option>")
        $('#_users_id option:first').attr("selected", "selected");
      }
      $.ajax( {
        url: "/results/semestre_selection",
        type: "GET",
        data: { semestre : $('#semestre option:selected').val(), subject : $('#_subject_id option:selected').val() },
      })
    })

    $('#semestre2').change(function () {
      if($('semestre2').val() == 'todos'){
        $('#_classroom2_id').empty()
        $('#_classroom2_id').prepend("<option value='todos'>Todos</option>")
        $('#_classroom2_id option:first').attr("selected", "selected");
        $('#_users2_id').empty()
        $('#_users2_id').prepend("<option value='todos'>Todas</option>")
        $('#_users2_id option:first').attr("selected", "selected");
      }
      $.ajax( {
        url: "/results/semestre2_selection",
        type: "GET",
        data: { semestre : $('#semestre2 option:selected').val(), subject : $('#_subject2_id option:selected').val() },
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