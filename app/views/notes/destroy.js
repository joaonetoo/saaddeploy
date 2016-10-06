$('#notes').html('<%= escape_javascript render (@notes) %>');
$('.modal').modal_success();