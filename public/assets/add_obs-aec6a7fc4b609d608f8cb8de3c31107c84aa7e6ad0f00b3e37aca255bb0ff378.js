$(document).ready(function(){$(".note_div").hide(),$(".add_button").click(function(){return $(".note_div").hide(),$(".add_button").show(),$(this).closest("div").find(".note_div").show(),$(this).hide(),!1}),$("form").bind("ajax:complete",function(){$(".note_div").hide(),$(".add_button").show()})});