
function buscarSoluciones(idTeo){
    var url = window.location.href + "/listaSolucion";
    var data = {};
    data["teoid"] = idTeo;
    $("#modalLoading").css('display','inline-block');
    $.ajax({
        type:'POST',
        url: url,
        dataType:'json',
        data:data,
        success: function(data){
            $("#modalLoading").css('display','none');
            var i = 0;
            $('#listaSoluciones').html("");
            var len = Object.keys(data.soluciones).length;
            var i;
            for (i=1; i <= len; i++){
                var key = "Proof "+i;
                var link = "<a href='javascript:buscarFormula("+ data.soluciones[key] +","+ data.idTeo +");'> ";
                link = link + key + "</a>";
                $('#listaSoluciones').append("<li>" + link +  " </li>");

            }
            if(len != 0){
                $("#panelSoluciones").removeClass("d-none");
                $('#formula').html("");
            }
            else{
                alert("EL teorema seleccionado no tiene soluciones guardadas.");
                $("#panelSoluciones").removeClass("d-none");
            }
        }
        
        
    });
}

function buscarMetaSoluciones(idTeo){
    $('#listaSoluciones').html("");
    var link = "<a href='javascript:buscarMetaFormula("+idTeo+");'> ";
    link = link + "Proof 1" + "</a>";
    $('#listaSoluciones').append("<li>" + link +  " </li>");
    $("#panelSoluciones").removeClass("d-none");
    $('#formula').html("");
}

function buscarFormula(idSol,idTeo){
    
    var data = {};
    var url = window.location.href + "/buscarFormula";
    data["idSol"] = idSol;
    data["idTeo"] = idTeo;
    $("#modalLoading").css('display','inline-block');
    $.ajax({
        type:'POST',
        url: url,
        dataType:'json',
        data:data,
        success: function(data){
            $("#modalLoading").css('display','none');
            $('#formula').html(data.historial);
            MathJax.Hub.Typeset();
        }
        
    });
}

function buscarMetaFormula(idTeo){
    var data = {};
    var url = window.location.href + "/buscarMetaFormula";
    data["idTeo"] = idTeo;
    $("#modalLoading").css('display','inline-block');
    $.ajax({
        type:'POST',
        url: url,
        dataType:'json',
        data:data,
        success: function(data){
            $("#modalLoading").css('display','none');
            $('#formula').html(data.historial);
            MathJax.Hub.Typeset();
        }
    });
}