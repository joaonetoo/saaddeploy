$('#language_curriculum').html("<%= escape_javascript render 'languages/language' %>");
 $.notify({
            message: 'Idioma deletado com sucesso!'
        },{
            type: 'pastel-success',
            delay: 4000,
            template: '<div data-notify="container" class="col-xs-11 col-sm-3 alert alert-{0}" role="alert">' +
                '<span data-notify="title">{1}</span>' +
                '<span data-notify="message">{2}</span>' +
            '</div>'
        });