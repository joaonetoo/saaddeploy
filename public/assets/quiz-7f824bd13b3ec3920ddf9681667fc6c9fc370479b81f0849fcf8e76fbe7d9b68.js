(function(){jQuery(function(){if($("#alerts-value-4").children().hide(),$("#recover input[type=radio]").on("change",function(){var e,t,i,s,a;if(a=$(this).val(),s=$(this).attr("name"),"4"!==a&&$("#p"+s).remove(),"4"===a)return $("#alerts-value-4").children().show(),t=$($(this).closest("tr")),i=t.children("tr td:nth-child(2)").text(),e=$('<li class="list-warning" id="p'+s+'"> <i class=" fa fa-ellipsis-v"></i> <div class="task-checkbox"> <input type="checkbox" name="extra'+s+'"/> </div> <div class="task-title"> <span class="task-title-sp" id="s'+s+'"></span> </div> </li>'),$("#sortable").append(e),$("#s"+s).append(i)}),$("#myform").submit(function(){var e,t,i;return t=0,i=0,$("#recover input[type=radio]").each(function(){if($(this).prop("checked"))return t+=1}),$("#extra input[type=checkbox]").each(function(){if($(this).prop("checked"))return i+=1}),40===t&&5===i?e=!0:(i<5?alert(5-i+" questoes extras sem pontuar"):i>5&&alert("Pontue apenas 5 quest\xf5es extras"),$("#notice").html(40-t+" Quest\xf5es sem marcar"),!1)}),complete===!0)return!0})}).call(this);