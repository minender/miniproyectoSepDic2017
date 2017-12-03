
$(function() {
    var form = $('#inferForm');
    
    $("#BtnInferir").click(function(ev){       
        ev.preventDefault();
        $("#Btn").val("Inferir");
        var formData = form.serialize();
        $.ajax({
            url: $(form).attr('action'),
            type: 'POST',
            dataType: 'json',
            data: formData,
            success: function(data) {
                if(data.errorParser2 !== null){
                    alert(data.Parser2);
                }
                else if(data.errorParser3 !== null){
                    alert(data.Parser3);
                }
                else{
                    
                    $('#formula').html(data.historial);
                    MathJax.Hub.Typeset();
                    
                    var nSol = $('#nSolucion').val();
                    if(nSol==="new"){
                        $('#nSolucion').val(data.nSol);
                        nSol = $('#nSolucion').val();
                        var url = $(form).attr('action');
                        url = url.replace("new",nSol);
                        $(form).attr('action',url);
                    }
                    
                    $('#nStatement_id').val("");
                    $('#instanciacion_id').val("");
                    $('#leibniz_id').val("");
                }
                
            }
        });
    });
    
    $("#BtnRetroceder").click(function(ev){       
        ev.preventDefault();
        $("#Btn").val("Retroceder");
        var formData = form.serialize();
        
        $.ajax({
            type: 'POST',
            url: $(form).attr('action'),
            dataType: 'json',
            data: formData,
            success: function(data) {

                $('#formula').html(data.historial);
                MathJax.Hub.Typeset();
                if(data.cambiarMetodo === "1"){
                    $("#metodosDemostracion").val("0");
                    $("#metodosDiv").show();
                    $('#inferForm').hide();
                    $('#nStatement_id').val("");
                    $('#instanciacion_id').val("");
                    $('#leibniz_id').val("");
                    $("#selectTeoInicial").val("1"); 
                }
                
            }
        });
    });
    
    $('#BtnLimpiar').click(function(){
        
        $('#nStatement_id').val("");
        $('#instanciacion_id').val("");
        $('#leibniz_id').val("");
    });
    
});
