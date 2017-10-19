
$(function() {
    var form = $('#inferForm');

    
    var resultado = $('#formula');
    
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
                alert(data.Parser2);
                alert(data.Parser3);
                if(data.errorParser2 !== null){
                    alert(data.Parser2);
                }
                else if(data.errorParser3 !== null){
                    alert(data.Parser3);
                }
                else{
                    
                    $('#formula').html(data.historial);
                    MathJax.Hub.Typeset();
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
            }
        });
    });
    
    $('#BtnLimpiar').click(function(){
        
        $('#nStatement_id').val("");
        $('#instanciacion_id').val("");
        $('#leibniz_id').val("");
    });
    
});
