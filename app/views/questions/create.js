$('#sendQuestion').modal('hide');
$('#questions').html('<%= escape_javascript render (@questions) %>');
$('#sendQuestion').modal_success();