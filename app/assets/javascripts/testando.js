$(document).ready(function () {
      $('#_users_id').empty()

    $('#_classroom_id').prepend("<option value='todos'>Todas</option>")
    $('#_classroom_id option:first').attr("selected", "selected");
    $('#_users_id').prepend("<option value='todos'>Todos</option>")
    $('#_users_id option:first').attr("selected", "selected");

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
});
