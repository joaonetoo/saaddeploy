$(document).ready(function () {
    $('input').change(function () {
                var atual = $(this)
                $(this).parent().siblings().each(function (){
                    $(this).find('input').each(function (){
                        if( $(this).val() == atual.val() && atual.val() > 0 ) {
                            atual.css("border", "5px solid red");
                            $(this).css("border", "5px solid red");
                        }
                    });
                });
    });
});




//        $(this).closest('.row').find('input').each(function (){
//                $(this).css("border", "5px solid red");
//        });