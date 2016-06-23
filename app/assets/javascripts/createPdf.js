$(document).ready(function(){


// We'll make our own renderer to skip this editor
var specialElementHandlers = {
    '#editor': function(element, renderer){
        return true;
    }
};

    $('#cmd').click(function () {
        var doc = new jsPDF('p', 'pt');
        var elem = document.getElementById('tabela_resultados');
        var data = doc.autoTableHtmlToJson(elem);

        var opts = {
            beforePageContent: function (data) {
                doc.text(20, 20, 'Nome');
            },
            afterPageContent: function (data) {
                doc.text(20, doc.autoTableEndPosY() + 20, 'Ancora1');
            }
        };
        doc.autoTable(data.columns, data.rows, opts);
        doc.save("table.pdf");

    });

});