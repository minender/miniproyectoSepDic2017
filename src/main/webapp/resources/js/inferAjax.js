function setForms(elegirMetodo) {

    // The value '1' is for when the user is still selecting demonstration methods because the first one
    // was not atomic. At that point, the buttons "Infer", "Go back" and "Clean" appear.
    if (elegirMetodo=='1') {
        $("#metodosDemostracion").val("0");
        $("#metodosDiv").show();
        $('#stSustLeibDiv').show();
        $('#jaxButtonsDiv').show();
        $('#BtnLimpiar').show();
        $('#BtnInferir').show();
        $("#inferForm").hide();
        $("#selectTeoInicial").val("1"); 
    } 
    // The value '2' is for when the demonstration is starting, so the user may select the demonstration
    // method but the buttons "Infer", "Go back" and "Clean" do not appear.
    else if (elegirMetodo=='2') {
        $("#metodosDemostracion").val("0");
        $("#metodosDiv").show();
        $("#inferForm").show();
        $('#BtnInferir').hide();
        $('#BtnLimpiar').hide();
        $('#jaxButtonsDiv').hide();
        $('#stSustLeibDiv').hide();
        $("#selectTeoInicial").val("1");
    } 
    // The rest is for when the demonstration is advanced, so he can make inferences, can go back
    // a step, and does not need to select a demonstration method.
    else {
        $("#selectTeoInicial").val("0");
        $('#stSustLeibDiv').show();
        $('#jaxButtonsDiv').show();
        $('#BtnLimpiar').show();
        $('#BtnInferir').show();
        $("#inferForm").show();
        $("#metodosDiv").hide();
        $("#currentTeo").hide();
    }
}

// Determines the last part of the url that will be sent to an infer controller
var urlTermination = {
    "DM Clickable": "/teoremaClickeableMD", // Direct method, clickable
    "SS Clickable": "/teoremaClickeablePL", // Starting from one side method, clickable

    DM: "/teoremaInicialMD", // Starting from one side method, clickable
    SS: "/teoremaInicialPL", // Starting from one side method
    WE: "/teoremaInicialD",  // Weakening method (The "D" refers to "Debilitamiento")
    ST: "/teoremaInicialF",  // Strenghtening method (The "F" refers to "Fortalecimiento")
    TR: "/iniStatementT",    // Transitivity method
    CO: "/iniStatementCO",   // Contradiction method
    CR: "/iniStatementCR",   // Counter-reciprocal method
    AI: "/iniAndI",          // And introduction method

    showInstantiation: "inst", // When we want to show the instantiation of the hint theorem
    setAutomaticSubst: "auto", // When we want the substitution to be made automatically
    automaticSubst:   "/auto", // When we want to get the automatic subsitution of the current hint theorem
};

// The operations that "instantiationAjax" could receive
var instantiationDict = { 
    showInstantiation: 0,
    setAutomaticSubst: 1,
    automaticSubst:    2,
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
    var data = {teoid, lado};
    var form = $('#inferForm');
    var completeSuccess = true;

    await $.ajax({
        type: 'POST',
        url: $(form).attr('action') + urlTermination[method],
        dataType: 'json',
        data,
        success: function(newData) {
            alert(newData.errorParser2);
            if(newData.lado === "0"){ // Remember that "lado" is also used to indicate errors
                alert("The selected method does not apply to the current theorem");
                $("#metodosDiv").show();
                completeSuccess = false;
            }
            else{
                $('#formula').html(newData.historial);
                MathJax.Hub.Typeset();

                // When the Ajax does not correspond to a theorem clickable, there is already an associated 
                // entry in the solucion table, so newData.nSol is not null.
                var clickable = (method.split(" ").pop() == "Clickable");
                if (!clickable){
                    setForms(newData.cambiarMetodo);

                    switch(method){
                        case "DM": // Direct method

                            // This makes the current theorem no longer be clickable
                            $(".teoIdName").css({"cursor":"","color":""});
                            $(".operator").css({"cursor":"pointer","color":"#08c"});

                            $("#currentTeo").hide();
                            break;

                        case "AI": // And introduction method
                            $("#metodosDiv").show(); // This overrides what was set in "setForms"
                        
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
function instantiationAjax(operation){
    let opNum = instantiationDict[operation];

    if ((opNum !== 2) || ($('#nStatement_id').val() != "")){
        var data = {};
        var action = $('#inferForm').attr('action');
        let url;

        if (opNum == 0){ // Show instantiation
            data["nStatement"] = $('#nStatement_id').val();
            data["instanciacion"] = setSubstitutionOnInput('substitutionButtonsId');
        }

        if (opNum == 2){ // Auntomatic substitution. (This is NOT an else if)
            data["nStatement"] = $('#nStatement_id').val();
            data["leibniz"] = setInputValueOnParser('leibnizSymbolsId');
            data["freeV"] = window["substitutionButtonsId._variables"].toString();

            url = action; 
        } else { // Show instantitation or set automatic substitution
            let arr = action.split('/');
            let attr1 = arr.pop();
            let attr2 = arr.pop();

            url = action.substring(0,action.length-(attr1.length+attr2.length+1) );
        }

        url += urlTermination[operation];
        $("#modalLoading").css('display','inline-block');

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url,
            data,
            success: function(newData) {
                $("#modalLoading").css('display','none');
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
                            $('#auto-sust-op').html("automatic substitution" + (newData.auto ? "<i class=\"fa fa-check\"></i>" : "") );
                            window['auto'] = newData.auto;
                            break;

                        case 2: // Automatic substitution
                            if (newData.sustFormatC != null){
                                let string, freeVars = window["substitutionButtonsId._variables"];

                                for (k=0; k < freeVars.length; k++){
                                    string = "substitutionButtonsId." + freeVars[k];
                                    cleanMathJax(string);

                                    if (newData.sustFormatC[k] != "")
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
                $("#modalLoading").css('display','none');
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

// This is called when we select a theorem from the right side of the view infer, in order to use
// it as a hint
function clickOperator(Math1,myField,teoid,vars){
    var render=document.getElementById(Math1);
    render.onclick = function (event) {
        var targetString = "";
        if (teoid.substring(0,3)==="ST-"){
            targetString = 'click@'+teoid.substring(3);
        }
        else if (teoid.substring(0,3)==="MT-"){
            targetString = 'clickmeta@'+teoid.substring(3);
        }
        if (!event){
            event = window.event;
        };
        var target = event.toElement || event.target;
        while (target && (!target.id || target.id !=targetString)) {
            target = target.parentNode;
        };
        if(target){
            var metodo = document.getElementById('metodosDemostracion').value;
            var check =  "";
            if (window['auto']){
                check = "<i class=\"fa fa-check\"></i>";
            }
            var div = 
                `<center>
                    <table>
                        <tr>
                            <td>Substitution:</td>
                            <td>
                                <div class=\"dropdown\">
                                    <button style=\"padding:.05rem .1rem;\" class=\"btn btn-secondary btn-sm dropdown-toggle\" type=\"button\" id=\"dropdownMenuButton\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\"></button>
                                    <div class=\"dropdown-menu\" aria-labelledby=\"dropdownMenuButton\">
                                        <a class=\"dropdown-item\" href=\"#\" onclick=\"instantiationAjax('showInstantiation');\" data-target=\"#instantiationModal\" data-toggle=\"modal\">show instantiation</a>
                                        <a id=\"auto-sust-op\" class=\"dropdown-item\" href=\"#\" onclick=\"instantiationAjax('setAutomaticSubst');\" data-toggle=\"modal\">automatic substitution`+check+`</a>
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
    };    
}