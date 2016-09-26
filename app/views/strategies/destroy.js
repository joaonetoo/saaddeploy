$('#objectives').html('<%= escape_javascript render (@objectives) %>');
$('#new_objective_modal').modal_success();