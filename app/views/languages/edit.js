
$(function (){
	$('#titulo').html( "<img  src='/assets/saad_30.png'> Editar Formação");
	$('#curriculumForm').html("<%= escape_javascript render partial: 'languages/form2' %>");
	$('#idioma').val('<%= @language.idioma %>');
	$('#curriculo').modal('show');

});

