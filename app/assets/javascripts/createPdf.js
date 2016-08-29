    function geraPdf(nomeUsuario,ancora1Nome, ancora1Descricao, ancora1Perfil, ancora1Perspectiva, ancora2Nome, ancora2Descricao, ancora2Perfil, ancora2Perspectiva) {
        var specialElementHandlers = {
        '#editor': function(element, renderer){
            return true;
        }
        }
        var doc = new jsPDF('p', 'pt');
        var elem = document.getElementById('tabela_resultados');
        var data = doc.autoTableHtmlToJson(elem);


        var ancora1text = ancora1Descricao + '\n\n\n' + ancora1Perfil + '\n\n\n' + ancora1Perspectiva;
        var text1 = doc.splitTextToSize(ancora1text, 900);

        var ancora2text = ancora2Descricao + '\n\n\n' + ancora2Perfil + '\n\n\n' + ancora2Perspectiva;
        var text2 = doc.splitTextToSize(ancora2text, 900);


        var opts = {
            beforePageContent: function (data) {
                var text = "Âncoras de carreira: " + nomeUsuario,
                xOffset = (doc.internal.pageSize.width / 2) - (doc.getStringUnitWidth(text) * doc.internal.getFontSize() / 2);
                doc.setFont("times");
                doc.setFontType("bold");
                doc.setFontSize(14);
                doc.text(text, xOffset, 20);
            },
            afterPageContent: function (data) {
                ancora1Nome = "1.0 " + ancora1Nome;
                var ancora1Title = ancora1Nome, xOffset = (doc.internal.pageSize.width / 2) - (doc.getStringUnitWidth(ancora1Nome) * doc.internal.getFontSize() / 2);
                doc.setFontType("bold");
                doc.setFontSize(12);
                doc.text(ancora1Title, xOffset, doc.autoTableEndPosY() + 50);
                doc.setFontType("normal");
                doc.setFontSize(10);
                doc.text(20, doc.autoTableEndPosY() + 100, text1);
                /*doc.text(20, doc.autoTableEndPosY() + 200, splitPerfil1);
                doc.text(20, doc.autoTableEndPosY() + 300, splitPerspectiva1);*/
                doc.addPage();
                ancora2Nome = "2.0 " + ancora2Nome;
                var ancora2Title = ancora2Nome, xOffset = (doc.internal.pageSize.width / 2) - (doc.getStringUnitWidth(ancora2Nome) * doc.internal.getFontSize() / 2);
                doc.setFontType("bold");
                doc.setFontSize(12);
                doc.text(ancora2Title, xOffset, 40);
                doc.setFontType("normal");
                doc.setFontSize(10);
                doc.text(20, 80, text2);


            }
        }


        doc.autoTable(data.columns, data.rows, opts);
        doc.save("table.pdf");

        }

