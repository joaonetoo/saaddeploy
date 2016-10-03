$('#questions').html('<%= escape_javascript render (@questions) %>');
$('#new_question_modal').modal_success();