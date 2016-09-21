$(document).ready(function () {

    $('#_classroom_id').empty()
    $('#_users_id').empty()
    $('#_subject_id').prepend("<option value='todos'>Todas</option>")
    $('#_subject_id option:first').attr("selected", "selected");
    $('#_classroom_id').prepend("<option value='todos'>Todas</option>")
    $('#_classroom_id option:first').attr("selected", "selected");
    $('#_users_id').prepend("<option value='todos'>Todos</option>")
    $('#_users_id option:first').attr("selected", "selected");

    $('#_subject_id').change(function () {
      if($('#_subject_id').val() == 'todos'){
        $('#_classroom_id').empty()
        $('#_classroom_id').prepend("<option value='todos'>Todas</option>")
        $('#_classroom_id option:first').attr("selected", "selected");
        $('#_users_id').empty()
        $('#_users_id').prepend("<option value='todos'>Todos</option>")
        $('#_users_id option:first').attr("selected", "selected");
      }
      $.ajax( {
        url: "subject_selection",
        type: "GET",
        data: { subject : $('#_subject_id option:selected').val() },
      })
    })

    $('#_classroom_id').change(function () {
      if($('#_classroom_id').val() == 'todos') {
        $('#_users_id').empty()
        $('#_users_id').prepend("<option value='todos'>Todos</option>")
        $('#_users_id option:first').attr("selected", "selected");
      }
      $.ajax( {
        url: "classroom_selection",
        type: "GET",
        data: { classroom : $('#_classroom_id option:selected').val() },
      })
    })
});