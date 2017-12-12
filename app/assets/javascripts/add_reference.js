$(document).each(function() {
   $(".relat__at").on("change", function(){
   $("#esatu2").toggle($(this).hasClass("relat__at_yes"));
   });
   }
);

$(document).ready(function() {
    $(".relat__atu").on("change", function(){
    $("#esatu").toggle($(this).hasClass("relat__atu_yes"));
    });
   }
);
