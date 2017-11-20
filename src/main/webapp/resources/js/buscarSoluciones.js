
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
            for(var key in data.soluciones){
                
                var link = "<a href='javascript:buscarFormula("+ data.soluciones[key] +","+ data.idTeo +");'style='cursor:pointer;'> ";
                link = link + key + "</a>"
                $('#lista').append("<li style='list-style: none;'>" + link +  " </li>");

                i++;
            }
            if(i>0){
                $("#panelSoluciones").show();
            }
            else{
                alert("EL teorema seleccionado no tiene soluciones guardadas.");
            }
        }
        
        
    });
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