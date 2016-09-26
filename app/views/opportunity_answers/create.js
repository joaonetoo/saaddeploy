$('#new_opportunity_modal').modal('hide');
$('body').removeClass('modal-open');
$('.modal-backdrop').remove();
$('#opportunities').html('<%= escape_javascript render (@opportunities) %>');
$('#new_opportunity_modal').modal_success();