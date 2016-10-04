$('#questions').html("<%= escape_javascript render(:partial => 'line_cases/line_questions') %>");
$('#new_question_modal').modal_success();