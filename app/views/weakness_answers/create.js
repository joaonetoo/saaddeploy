$('#new_weakness_modal').modal('hide');
$('body').removeClass('modal-open');
$('.modal-backdrop').remove();
$('#weaknesses').html('<%= escape_javascript render (@weaknesses) %>');
$('#new_weakness_modal').modal_success();