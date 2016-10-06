$('#notes').html('<%= escape_javascript render (@notes) %>');
$('.modal fade').modal_success();