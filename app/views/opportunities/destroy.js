$('#opportunities').html('<%= escape_javascript render (@opportunities) %>');
$('#new_opportunity_modal').modal_success();