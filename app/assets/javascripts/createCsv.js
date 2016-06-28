$(document).ready(function () {

    function exportTableToCSV($table, filename) {

        // Debug info ---------------------------------------------------------------
        console.log($table);
        console.log(filename);
        var $rows2 = $table.find('tr:has(td)');
        console.log($rows2);
        var tmpColDelim2 = String.fromCharCode(11);
        var tmpRowDelim2 = String.fromCharCode(0);
        var colDelim2 = ',';
        var rowDelim2 = '\r\n';
        var csv = $rows2.map(function (i, row) {
            var $row2 = $(row),
                $cols2 = $row2.find('td');

            return $cols2.map(function (j, col) {
                var $col2 = $(col),
                    text = '"' + $col2.text().replace(/(\r\n|\n|\r)/gm, "").trim() + '"';

                return text //.replace('"', '""'); // escape double quotes

            }).get().join(tmpColDelim2);

        }).get().join(tmpRowDelim2)
            .split(tmpRowDelim2).join(rowDelim2)
            .split(tmpColDelim2).join(colDelim2);
        console.log(csv);
        // End debug -----------------------------------------------------------------

        var $rows = $table.find('tr:has(td)'),

            // Temporary delimiter characters unlikely to be typed by keyboard
            // This is to avoid accidentally splitting the actual contents
            tmpColDelim = String.fromCharCode(11), // vertical tab character
            tmpRowDelim = String.fromCharCode(0), // null character

            // actual delimiter characters for CSV format
            colDelim = ",",
            rowDelim = "\r\n",

            // Grab text from table into CSV formatted string
            csv = $rows.map(function (i, row) {
                var $row = $(row),
                    $cols = $row.find('td');

                return $cols.map(function (j, col) {
                    var $col = $(col),
                        text = '"' + $col.text().replace(/(\r\n|\n|\r)/gm, "").trim() + '"';

                    return text //.replace('"', '""'); // escape double quotes

                }).get().join(tmpColDelim);

            }).get().join(tmpRowDelim)
                .split(tmpRowDelim).join(rowDelim)
                .split(tmpColDelim).join(colDelim),
            // Data URI
            csvData = 'data:application/csv;charset=utf-8,' + encodeURIComponent(csv);

        $(this)
            .attr({
            'download': filename,
                'href': csvData,
                'target': '_blank'
        });
    }

    // This must be a hyperlink
    $("#export").on('click', function (event) {
        // CSV
        exportTableToCSV.apply(this, [$('#dados'), 'export.csv']);

        // IF CSV, don't do event.preventDefault() or return false
        // We actually need this to be a typical hyperlink
    });
});

jQuery.fn.table2CSV = function (options) {
    var options = jQuery.extend({
        separator: ',',
        header: [],
        delivery: 'popup' // popup, value
    },
    options);

    var csvData = [];
    var headerArr = [];
    var el = this;

    //header
    var numCols = options.header.length;
    var tmpRow = []; // construct header avalible array

    if (numCols > 0) {
        for (var i = 0; i < numCols; i++) {
            tmpRow[tmpRow.length] = formatData(options.header[i]);
        }
    } else {
        $(el).filter(':visible').find('th').each(function () {
            if ($(this).css('display') != 'none') tmpRow[tmpRow.length] = formatData($(this).html());
        });
    }

    row2CSV(tmpRow);

    // actual data
    $(el).find('tr').each(function () {
        var tmpRow = [];
        $(this).filter(':visible').find('td').each(function () {
            if ($(this).css('display') != 'none') tmpRow[tmpRow.length] = formatData($(this).html());
        });
        row2CSV(tmpRow);
    });
    if (options.delivery == 'popup') {
        var mydata = csvData.join('\n');
        return popup(mydata);
    } else {
        var mydata = csvData.join('\n');
        return mydata;
    }

    function row2CSV(tmpRow) {
        var tmp = tmpRow.join('') // to remove any blank rows
        // alert(tmp);
        if (tmpRow.length > 0 && tmp != '') {
            var mystr = tmpRow.join(options.separator);
            csvData[csvData.length] = mystr;
        }
    }

    function formatData(input) {
        // replace " with â€œ
        var regexp = new RegExp(/["]/g);
        var output = input.replace(regexp, "â€œ");
        //HTML
        var regexp = new RegExp(/\<[^\<]+\>/g);
        var output = output.replace(regexp, "");
        if (output == "") return '';
        return '"' + output + '"';
    }

    function popup(data) {
        var generator = window.open('', 'csv', 'height=400,width=600');
        generator.document.write('<html><head><title>CSV</title>');
        generator.document.write('</head><body >');
        generator.document.write('<textArea cols=70 rows=15 wrap="off" >');
        generator.document.write(data);
        generator.document.write('</textArea>');
        generator.document.write('</body></html>');
        generator.document.close();
        return true;
    }
};