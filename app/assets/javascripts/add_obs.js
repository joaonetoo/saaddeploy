$(document).ready(function() {
    $(".note_div").hide();
    $(".add_button").click(function() {
        $(".note_div").hide();
        $(".add_button").show();
        $(this).closest("div").find('.note_div').show();
        $(this).hide();
        return false;
    });

    $("form").bind('ajax:complete', function() {
        $(".note_div").hide();
        $(".add_button").show();
   });

});