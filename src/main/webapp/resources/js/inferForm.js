$(function() {
    var form = $('#inferForm');
    
    // "Infer" button
    $("#BtnInferir").click(async function(ev){ 
        if (buttonsEnabled){
            await setInputValueOnParser('leibnizSymbolsId');
            await setSubstitutionOnInput('substitutionButtonsId');  
            ev.preventDefault();
            $("#Btn").val("Inferir");
            var formData = form.serialize();
            $("#loadingModal").css('display','inline-block');

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
                        MathJax.Hub.Typeset();

                        var proof = $('.proof');
                        proof.scrollTop(proof[0].scrollHeight);

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
                    }
                },
                error: function(XMLHttpRequest, textStatus, errorThrown) { 
                    $("#loadingModal").css('display','none');
                    alert("Status: " + textStatus); alert("Error: " + errorThrown);
                }
            });
        }
    });
    
    // "Go back" button
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
                    setViewState(data.cambiarMetodo);                    
                },
                error: function(XMLHttpRequest, textStatus, errorThrown) { 
                    $("#loadingModal").css('display','none');
                    alert("Status: " + textStatus); alert("Error: " + errorThrown); 
                }
            });
        }
    });
    
    // "Clean" button
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

// This is activated when the user highlights part of the last line of the demonstration
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