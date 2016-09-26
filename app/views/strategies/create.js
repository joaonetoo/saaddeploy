$('#new_objective_modal').modal('hide');
$('body').removeClass('modal-open');
$('.modal-backdrop').remove();
$('#objectives').html('<%= escape_javascript render (@objectives) %>');
$('#new_objective_modal').modal_success();