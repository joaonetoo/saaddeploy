$('#weaknesses').html('<%= escape_javascript render (@weaknesses) %>');
$('#new_weakness_modal').modal_success();