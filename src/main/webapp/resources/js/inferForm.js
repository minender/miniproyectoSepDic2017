$(function() {
    var form = $('#inferForm');
    
    $("#BtnInferir").click(async function(ev){ 
        if (buttonsEnabled){
            await setInputValueOnParser('leibnizSymbolsId');
            await setSubstitutionOnInput('substitutionButtonsId');  
            ev.preventDefault();
            $("#Btn").val("Inferir");
            var formData = form.serialize();
            $("#loadingModal").css('display','inline-block');

            start = performance.now();

            $.ajax({
                url: $(form).attr('action'),
                type: 'POST',
                dataType: 'json',
                data: formData,
                success: function(data) {

                    $("#loadingModal").css('display','none');
                    if(data.errorParser2 !== null){
                        alert(data.Parser2);
                    }
                    else if(data.errorParser3 !== null){
                        alert(data.Parser3);
                    }
                    else{
                        $('#formula').html(data.historial);
                        console.log("Tiempo regreso = ", performance.now() - start);
                        
                        MathJax.Hub.Queue(["Typeset",MathJax.Hub], function(){
                            console.log("Tiempo typeset = ", performance.now() - start);
                        });
                        //MathJax.Hub.Typeset();
                        var proof = $('.proof');
                        proof.scrollTop(proof[0].scrollHeight);
                        /*var nSol = $('#nSolucion').val();
                        if(nSol==="new"){
                            $('#nSolucion').val(data.nSol);
                            nSol = $('#nSolucion').val();
                            var url = $(form).attr('action');
                            url = url.replace("new",nSol);
                            $(form).attr('action',url);
                        }*/
                        if(data.resuelto === "1"){
                            alert("Congratulations you have found a proof of the theorem!!");
                            window.location = $("#linkMyTheorems").attr("href");
                        }

                        // Verifies if it has ended a proof for a case.
                        if (data.endCase) {
                            alert("Congratulations you have found a proof of a case!");
                
                            $("#metodosDiv").show();
                			$('#metodosDemostracion').val("0");
                			let message = "Please, select a proof method for the case.";
                            openModalWithConfirmation(message);
                        }

                        if (data.valid) {
                            $('#nStatement_id').val("");
                            $('#instanciacion_id').val("");
                            $('#leibniz_id').val("");
                            $('#stbox').text("");
                            cleanJax('leibnizSymbolsId');
                            cleanJaxSubstitution('substitutionButtonsId');
                        }
                        //$("#nuevoMetodo").val("0");
                    }
                    
                },
                error: function(XMLHttpRequest, textStatus, errorThrown) { 
                    $("#loadingModal").css('display','none');
                    alert("Status: " + textStatus); alert("Error: " + errorThrown);
                }
            });
        }
    });
    
    $("#BtnRetroceder").click(function(ev){
        if (buttonsEnabled){    
            ev.preventDefault();
            $("#Btn").val("Retroceder");
            var formData = form.serialize();
            $("#loadingModal").css('display','inline-block');
            $.ajax({
                type: 'POST',
                url: $(form).attr('action'),
                dataType: 'json',
                data: formData,
                success: function(data) {
                    $("#loadingModal").css('display','none');
                    $('#formula').html(data.historial);
                    MathJax.Hub.Typeset();
                    var proof = $('.proof');
                    proof.scrollTop(proof[0].scrollHeight);
                    $('#nStatement_id').val("");
                    $('#instanciacion_id').val("");
                    $('#leibniz_id').val("");
                    $('#stbox').text("");
                    cleanJax('leibnizSymbolsId');
                    cleanJaxSubstitution('substitutionButtonsId');
                    setForms(data.cambiarMetodo);                    
                },
                error: function(XMLHttpRequest, textStatus, errorThrown) { 
                  $("#loadingModal").css('display','none');
                  alert("Status: " + textStatus); alert("Error: " + errorThrown); 
                }
            });
        }
    });
    
    $('#BtnLimpiar').click(async function(){
        await cleanJax('leibnizSymbolsId'); 
        await cleanJaxSubstitution('substitutionButtonsId');
        $('#nStatement_id').val("");
        $('#instanciacion_id').val("");
        $('#leibniz_id').val("");
        $('#stbox').text("");
        
        document.getElementById('substitutionButtonsId.SubstitutionDiv').children[0].innerHTML = "Substitution:";
    });
    
});

function hasNumericClass(element){
    let clases = $(element).attr("class");
    isNumeric = false;
    if (clases){
        clases = clases.split(" ");
        for (let i = 0; i<clases.length;i++){
            if ($.isNumeric(clases[i])){
                isNumeric = true;
            }
        }
    }
    return isNumeric;  
}

function leibnizMouse(p1,p2){
    if (p1===p2) {
        // To be executed inside inferRecoverC
        let auxiliarFunction = (variablesSaved) => {
            if (window['auto']){
                instantiationAjax("automaticSubst", variablesSaved);
            }
        }
        $('#leibniz_id').val(inferRecoverC(leibniz[p1], leibnizLatex[p1],'leibnizSymbolsId_', auxiliarFunction));
    }
}