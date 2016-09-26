$('#threats').html('<%= escape_javascript render (@threats) %>');
$('#new_threat_modal').modal_success();