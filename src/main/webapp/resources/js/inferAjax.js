function setForms(elegirMetodo) {
    // The value '1' is for when the user must select a demonstration method, so the list of theorems
    // must not be rendered
    if (elegirMetodo=='1') {
        $("#teoremas").hide();
        $("#metodosDemostracion").val("0");
        $("#metodosDiv").show();
        $('#stSustLeibDiv').show();
        $('#jaxButtonsDiv').show();
        $('#BtnLimpiar').show();
        $('#BtnInferir').show();
        $("#inferForm").hide();
        $("#selectTeoInicial").val("1"); 
    } 
    // The value '2' is for when the user has selected a demostration method but still has to select another
    // one because the previous was not atomic. 
    else if (elegirMetodo=='2') {
        $("#teoremas").hide();
        $("#metodosDemostracion").val("0");
        $("#metodosDiv").show();
        $("#inferForm").show();
        $('#BtnInferir').hide();
        $('#BtnLimpiar').hide();
        $('#jaxButtonsDiv').hide();
        $('#stSustLeibDiv').hide();
        $("#selectTeoInicial").val("1");
    } 
    // The rest is for when the user still has to select the theorem to be proved or when the
    // demostration is advanced, so he can make inferences, can go back a step, and does not 
    // need to select a demonstration method.
    else {
        $("#teoremas").show();
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

// This object determines the last part of the url that will be sent to an infer controller
var urlTermination = {
    showInstantiation: "inst", // When we want to show the instantiation of the hint theorem
    setAutomaticSubst: "auto", // When we want the substitution to be made automatically
    automaticSubst:   "/auto", // When we want to get the automatic subsitution of the current hint theorem
};

// This object determines the operations that "instantiationAjax" could receive
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
                    setForms(newData.cambiarMetodo);

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
async function instantiationAjax(operation){
    let opNum = instantiationDict[operation];

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
            data["leibniz"] = await setInputValueOnParser('leibnizSymbolsId');
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

        await $.ajax({
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
            targetString = 'clickmeta@'+teoid.substring(3);
        }
        if (!event){
            event = window.event;
        };
        // var target = event.toElement || event.target;
        // while (target && (!target.id || target.id !==targetString)) {
        //     target = target.parentNode;
        // };
        var target = document.getElementById(targetString);
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
    };    
}