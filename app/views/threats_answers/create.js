$('#new_threat_modal').modal('hide');
$('body').removeClass('modal-open');
$('.modal-backdrop').remove();
$('#threats').html('<%= escape_javascript render (@threats) %>');
$('#new_threat_modal').modal_success();