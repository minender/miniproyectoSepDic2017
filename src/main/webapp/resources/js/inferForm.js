// "arrayShow" and "arrayHide" are arrays of strings, but "arrayValues" is an array of arrays
function setElementsVisibility(arrayShow, arrayHide, arrayValues){
    for (i=0; i < arrayShow.length; i++){
        $("#"+arrayShow[i]).show();
    }
    for (i=0; i < arrayHide.length; i++){
        $("#"+arrayHide[i]).hide();
    }
    for (i=0; i < arrayValues.length; i++){
        let elem = arrayValues[i];
        $("#"+elem[0]).val(elem[1]);
    }
}

function setViewState(elegirMetodo) {
    let arrayShow = [];
    let arrayHide = [];
    let arrayValues = [];

    // The value '1' is for when the user must select a demonstration method, so the list of theorems
    // must not be rendered
    if (elegirMetodo=='1') {
        arrayShow = ["metodosDiv", "stSustLeibDiv", "jaxButtonsDiv", "BtnLimpiar", "BtnInferir"];
        arrayHide = ["teoremas", "inferForm"];
        arrayValues = [["metodosDemostracion", "0"], ["selectTeoInicial", "1"]];
    } 
    // The value '2' is for when the user has selected a demostration method but still has to select another
    // one because the previous was not atomic. 
    else if (elegirMetodo=='2') {
        arrayShow = ["metodosDiv", "inferForm"];
        arrayHide = ["teoremas", "stSustLeibDiv", "jaxButtonsDiv", "BtnLimpiar", "BtnInferir"];
        arrayValues = [["metodosDemostracion", "0"], ["selectTeoInicial", "1"]];
    } 
    // The rest is for when the user still has to select the theorem to be proved or when the
    // demostration is advanced, so he can make inferences, can go back a step, and does not 
    // need to select a demonstration method.
    else {
        arrayShow = ["teoremas", "inferForm", "stSustLeibDiv", "jaxButtonsDiv", "BtnLimpiar", "BtnInferir"];
        arrayHide = ["metodosDiv", "currentTeo"];
        arrayValues = [["selectTeoInicial", "0"]];
    }
    setElementsVisibility(arrayShow, arrayHide, arrayValues);
}

/**
 * Function to send an AJAX to InferController when the user selects a demonstration method, or when
 * has selected the initial theorem of a direct proof, or when has selected the side of a "starting from
 * one side" method.
 *
 * @param method -> demonstration method.
 * @param lado -> when proving with starting from one side, select the side from which the proof may begin.
 * @param teoid -> id of the theorem that is going to be proved.
 *
 * @return -> boolean that is only true when the AJAX was send successfully and the method can be applied to the theorem
 */
async function proofMethodAjax(method, teoid=null, lado=null){
    var data = {
        teoid, 
        lado,
        // Remember the parameter method can have the "Clickable" termination, that we don't want to send
        method: method.substring(0,2), 
    };
    var form = $('#inferForm');
    var completeSuccess = true;
    var methodSeparated = method.split(" ");
    var clickable = (methodSeparated.pop() === "Clickable");

    await $.ajax({
        type: 'POST',
        url: $(form).attr('action') + (clickable ? "/clickableST" : "/iniStatement"),
        dataType: 'json',
        data,
        success: function(newData) {
            if(newData.errorParser1){
                alert("The selected method does not apply to the current statement");
                $("#metodosDiv").show();
                completeSuccess = false;
            }
            else{
                $('#formula').html(newData.historial);
                MathJax.Hub.Typeset();

                // When the Ajax does not correspond to a theorem clickable, there is already an associated 
                // entry in the solucion table, so newData.nSol is not null.
                if (!clickable){
                    setViewState(newData.cambiarMetodo);

                    switch(method){
                        case "DM": // Direct method

                            // This makes the current theorem no longer be clickable
                            $(".teoIdName").css({"cursor":"","color":""});
                            $(".operator").css({"cursor":"pointer","color":"#08c"});

                            $("#currentTeo").hide();
                            break;

                        case "AI": // And introduction method
                        case "MI": // Mutual implication method
                        case "CA": // Case analysis method
                            $("#metodosDiv").show(); // This overrides what was set in "setViewState"
                        
                        default:
                            break;
                    }

                    // Note this can only be made when clickable is false because newData.nSol is not null. 
                    var nSol = $(form).attr('action').split('/').pop();
                    if(nSol === "new"){
                        var url = $(form).attr('action');

                        // We delete the last 3 characters because we know they are "new" and replace them with the new nSol
                        url = url.substring(0,url.length-3) + newData.nSol;
                        $(form).attr('action',url);
                    }
                }
                // In the direct method case we want to show again the theorems list so the user can select one of them
                else if (methodSeparated[0] === "DM") {
                    $("#teoremas").show();
                }
            }
        }, error: function(XMLHttpRequest, textStatus, errorThrown) { 
            alert("Status: " + textStatus); alert("Error: " + errorThrown/*XMLHttpRequest.responseText*/); 
            completeSuccess = false;
        }
    });
    return completeSuccess;
}

// Method to show the instantiation used of an already proven theorem, get a substitution
// of it, or set if the substitution is made automatically or not.
async function instantiationAjax(operation, variablesSaved=null){

    // Indicates the last part of the url that will be sent to an infer controller
    // depending on the operation, and the operation id.
    const operationDict = {
        // When we want to show the instantiation of the hint theorem
        showInstantiation: {
            urlTermination: "inst",
            id: 0,
        },
        // When we want the substitution to be made automatically
        setAutomaticSubst: {
            urlTermination: "auto",
            id: 1,
        },
        // When we want to get the automatic subsitution of the current hint theorem
        automaticSubst: {
            urlTermination: "/auto",
            id: 2, 
        }
    }
    const opObject = operationDict[operation];
    const opNum = opObject.id;

    if ((opNum !== 2) || ($('#nStatement_id').val() != "")){
        var data = {};
        var action = $('#inferForm').attr('action');
        let url;

        if (opNum === 0){ // Show instantiation
            data["nStatement"] = $('#nStatement_id').val();
            data["instanciacion"] = await setSubstitutionOnInput('substitutionButtonsId');
        }

        if (opNum === 2){ // Automatic substitution. (This is NOT an else if)
            data["nStatement"] = $('#nStatement_id').val();
            data["leibniz"] = await setInputValueOnParser('leibnizSymbolsId', variablesSaved);
            data["freeV"] = window["substitutionButtonsId._variables"].toString();

            url = action; 
        } else { // Show instantitation or set automatic substitution
            let arr = action.split('/');
            let attr1 = arr.pop();
            let attr2 = arr.pop();

            url = action.substring(0,action.length-(attr1.length+attr2.length+1) );
        }

        url += opObject.urlTermination;
        $("loadingModal").css('display','inline-block');

        await $.ajax({
            type: 'POST',
            dataType: 'json',
            url,
            data,
            success: function(newData) {
                $("#loadingModal").css('display','none');
                if(newData.error !== null){
                    alert(newData.error);
                }
                else{
                    switch (opNum){
                        case 0: // Show instantiation
                            $('#showInstantiation').html('$'+newData.instantiation+'$');
                            MathJax.Hub.Typeset();
                            break;

                        case 1: // Set automatic substitution
                            $('#auto-sust-op').html("automatic substitution" + (newData.auto ? `<i class="fa fa-check"></i>` : "") );
                            window['auto'] = newData.auto;
                            break;

                        case 2: // Automatic substitution
                            if (newData.sustFormatC !== null){
                                let string, freeVars = window["substitutionButtonsId._variables"];

                                for (k=0; k < freeVars.length; k++){
                                    string = "substitutionButtonsId." + freeVars[k];
                                    cleanMathJax(string);

                                    if (newData.sustFormatC[k] !== "")
                                        inferRecoverC(newData.sustFormatC[k], newData.sustLatex[k], string);
                                    else
                                        cleanParserString(string);
                                }
                            }
                            break;
                        default:
                            break;
                    }
                }
            }, error: function(XMLHttpRequest, textStatus, errorThrown) { 
                $("#loadingModal").css('display','none');
                alert("Status: " + textStatus); alert("Error: " + errorThrown/*XMLHttpRequest.responseText*/); 
            }
        });
    }
}

// This function is called when in the direct method we select as the initial theorem one
// that is not which we are currently trying to prove
function clickTeoremaInicial(teoid){
    var id = "";
    if (teoid.substring(0,3)==="ST-"){
        id = 'teoIdName'+teoid.substring(3);
    }
    else if (teoid.substring(0,3)==="MT-"){
        id = 'metateoIdName'+teoid.substring(3);
    }
    document.getElementById(id).onclick = function(event){
        var selectTeoInicial = $("#selectTeoInicial").val();
        if (selectTeoInicial==="1"){
            proofMethodAjax("DM", teoid);
        }
    };
}

// This function may seem that is which is activated when the user clicks on one of the theorems on the right
// in the "Prove" view to use it as a hint. BUT IT IS NOT. It is called when the page is rendering, and it assigns
// to each theorem, that is an HTML portion, the function that will in fact be activated when the user clicks on it.
function clickOperator(Math1,myField,teoid,vars){
    var render=document.getElementById(Math1);

    // Here is where we assign to each theorem the function that will be activated when the user clicks on it.
    render.onclick = function (event) {
        var targetString = "";
        if (teoid.substring(0,3)==="ST-"){
            targetString = 'click@'+teoid.substring(3);
        }
        else if (teoid.substring(0,3)==="MT-"){
            targetString = 'click@MT-'+teoid.substring(3);
        }
        if (!event){
            event = window.event;
        };
        var target = event.toElement || event.target;
        // This is to avoid that the user selects the theorem by clicking any part of it that is
        // not the main operator. If they click another part, this while will look for the parents
        // until there are no more, so the value will be null, and therefore we will not enter the if.
        while (target && (!target.id || target.id !==targetString)) {
            target = target.parentNode;
        };
        if(target){
            var metodo = document.getElementById('metodosDemostracion').value;
            var check =  "";
            if (window['auto']){
                check = `<i class="fa fa-check"></i>`;
            }
            var div = 
                `<center>
                    <table>
                        <tr>
                            <td>Substitution:</td>
                            <td>
                                <div class="dropdown">
                                    <button style="padding:.05rem .1rem;" class="btn btn-secondary btn-sm dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></button>
                                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                        <a class="dropdown-item" href="#" onclick="instantiationAjax('showInstantiation');" data-target="#instantiationModal" data-toggle="modal">show instantiation</a>
                                        <a id="auto-sust-op" class="dropdown-item" href="#" onclick="instantiationAjax('setAutomaticSubst');" data-toggle="modal">automatic substitution`+check+`</a>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </center>`;
            var enter = true;
            if(metodo === "1"){
                var selectTeoInicial = $("#selectTeoInicial").val(); 
                if(selectTeoInicial==="1"){
                    enter = false;
                }
            }
            if(enter) {
                var inputStatement = document.getElementById(myField);
                inputStatement.value = teoid;
                $('#stbox').text(teoid);
                $('#instantiationModal').children().children().children().children()[0].innerText = "Instantiation of "+teoid.substring(3);
                document.getElementById('substitutionButtonsId.SubstitutionDiv').children[0].innerHTML = div;
                setJaxSubstitutionVariables(vars,'substitutionButtonsId');
                if (window['auto']){
                    instantiationAjax("automaticSubst");
                }         
            }
        }
    }   
}

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