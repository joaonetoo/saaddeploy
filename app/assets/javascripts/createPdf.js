    function geraPdf(nomeUsuario,ancora1Nome, ancora1Descricao, ancora1Perfil, ancora1Perspectiva, ancora2Nome, ancora2Descricao, ancora2Perfil, ancora2Perspectiva) {
        var specialElementHandlers = {
        '#editor': function(element, renderer){
            return true;
        }
        }
        var doc = new jsPDF('p', 'pt');
        var elem = document.getElementById('tabela_resultados');
        var data = doc.autoTableHtmlToJson(elem);
        var splitDescricao1 = doc.splitTextToSize(ancora1Descricao, 800);
        var splitPerfil1 = doc.splitTextToSize(ancora1Perfil, 800);
        var splitPerspectiva1 = doc.splitTextToSize(ancora1Perspectiva, 800);

        var splitDescricao2 = doc.splitTextToSize(ancora2Descricao, 800);
        var splitPerfil2 = doc.splitTextToSize(ancora2Perfil, 800);
        var splitPerspectiva2 = doc.splitTextToSize(ancora2Perspectiva, 800);

        var opts = {
            beforePageContent: function (data) {
                var text = "Âncoras de carreira: " + nomeUsuario,
                xOffset = (doc.internal.pageSize.width / 2) - (doc.getStringUnitWidth(text) * doc.internal.getFontSize() / 2);
                doc.setFont("arial");
                doc.setFontType("bold");
                doc.setFontSize(14);
                doc.text(text, xOffset, 20);
                var dim = doc.getTextDimensions(text);
                console.log(dim);
            },
            afterPageContent: function (data) {
                /*var text = "Hi How are you",
                xOffset = (doc.internal.pageSize.width / 2) - (doc.getStringUnitWidth(text) * doc.internal.getFontSize() / 2);
                doc.text(text, xOffset, 250);*/
                doc.text(20, doc.autoTableEndPosY() + 30, ancora1Nome);
                doc.text(20, doc.autoTableEndPosY() + 60, splitDescricao1);
                doc.text(20, doc.autoTableEndPosY() + 200, splitPerfil1);
                doc.text(20, doc.autoTableEndPosY() + 300, splitPerspectiva1);
                doc.addPage();
                doc.text(20, 40, ancora2Nome);
                doc.text(20, 100, splitDescricao2);
                doc.text(20, 300, splitPerfil2);
                doc.text(20, 500, splitPerspectiva2);

            }
        }
        doc.autoTable(data.columns, data.rows, opts);
        doc.save("table.pdf");

        }

