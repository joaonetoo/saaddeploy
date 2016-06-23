$(document).ready(function(){


// We'll make our own renderer to skip this editor
var specialElementHandlers = {
    '#editor': function(element, renderer){
        return true;
    }
};

    $('#cmd').click(function () {
        var doc = new jsPDF('p', 'pt');
        var res = doc.autoTableHtmlToJson(document.getElementById("tabela_resultados"));
        doc.autoTable(res.columns, res.data, {margin: {top: 80}});
        var header = function(data) {
        doc.setFontSize(18);
        doc.setTextColor(40);
        doc.setFontStyle('normal');
        //doc.addImage(headerImgData, 'JPEG', data.settings.margin.left, 20, 50, 50);
        doc.text("Ancoras", data.settings.margin.left, 50);
  };



  doc.save("table.pdf");

    });

});