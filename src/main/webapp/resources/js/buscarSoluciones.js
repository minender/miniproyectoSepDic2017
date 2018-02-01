
function buscarSoluciones(idTeo){
    var url = window.location.href + "/listaSolucion";
    var data = {};
    data["teoid"] = idTeo;
    $.ajax({
        type:'POST',
        url: url,
        dataType:'json',
        data:data,
        success: function(data){
            var i = 0;
            $('#lista').html("");
            var len = Object.keys(data.soluciones).length;
            var i;
            for (i=1; i <= len; i++){
                var key = "Proof "+i;
                var link = "<a href='javascript:buscarFormula("+ data.soluciones[key] +","+ data.idTeo +");'style='cursor:pointer;'> ";
                link = link + key + "</a>";
                $('#lista').append("<li style='list-style: none;'>" + link +  " </li>");

            }
            if(len != 0){
                $("#panelSoluciones").show();
                $('#formula').html("");
            }
            else{
                alert("EL teorema seleccionado no tiene soluciones guardadas.");
                $("#panelSoluciones").hide();
            }
        }
        
        
    });
}

function buscarMetaSoluciones(idTeo){
    $('#lista').html("");
    var link = "<a href='javascript:buscarMetaFormula("+idTeo+");'style='cursor:pointer;'> ";
    link = link + "Solucion 1" + "</a>";
    $('#lista').append("<li style='list-style: none;'>" + link +  " </li>");
    $("#panelSoluciones").show();
    $('#formula').html("");
}

function buscarFormula(idSol,idTeo){
    
    var data = {};
    var url = window.location.href + "/buscarFormula";
    data["idSol"] = idSol;
    data["idTeo"] = idTeo;
    
    $.ajax({
        type:'POST',
        url: url,
        dataType:'json',
        data:data,
        success: function(data){
            $('#formula').html(data.historial);
            MathJax.Hub.Typeset();
        }
        
    });
}

function buscarMetaFormula(idTeo){
    var data = {};
    var url = window.location.href + "/buscarMetaFormula";
    data["idTeo"] = idTeo;
    
    $.ajax({
        type:'POST',
        url: url,
        dataType:'json',
        data:data,
        success: function(data){
            $('#formula').html(data.historial);
            MathJax.Hub.Typeset();
        }
    });
}