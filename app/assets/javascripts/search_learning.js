$(document).ready(function () {
    $('#_subject_id').change(function () {
      $.ajax( {
        url: "selection",
        type: "GET",
        data: { subject : $('#_subject_id option:selected').val() },
      })
    })
});