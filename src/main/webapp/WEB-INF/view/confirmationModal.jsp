<!-- Modal -->
<div class="modal fade" id="confirmationModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 450px;">
            <div class="modal-header" id="modal-header">
                <!-- Place holder for header -->
            </div>
            <div class="modal-body" id="modal-body">  
                <!-- Placeholder for message -->
            </div>
            <div class="modal-footer d-flex justify-content-center">
                <!-- ACCEPT/CANCEL BUTTONS -->
                <div class="container-fluid" id='accept-cancel-buttons'>
                    <div class="row d-flex justify-content-center" style="margin-left: 0 !important;">
                        <div class="col-md-6 d-flex justify-content-center">
                            <!-- cancels the confirmation -->
                            <button type="button" class="btn btn-danger" style="width: 100px !important;" onclick="closeModal()">
                                Cancel
                            </button>
                        </div>
                        <div class="col-md-6 d-flex justify-content-center">
                            <!-- accepts the confirmation -->
                            <button type="button" class="btn btn-success" style="width: 100px !important;" onclick="accept()">
                                Accept
                            </button>
                        </div>
                    </div>
                </div>
                <!-- INPUT BLOCK -->
                <div class="container-fluid" id='input_cases'>
                    <input name="nCases" id="nCases_id" value=""/>
                </div>
                <!-- OK BUTTONS BLOCK -->
                <div class="container-fluid" id='ok-buttons'>
                    <div class="row d-none d-flex justify-content-center">
                        <div class="col-md-6 d-flex justify-content-center">
                            <!-- closes the modal -->
                            <button type="button" class="btn btn-default" style="width: 100px !important;" onclick="okButton()">
                                OK
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
        
<!-- Modal Trigger Function -->
<script type="text/javascript">
    function openModalWithConfirmation(message) {
        document.getElementById('modal-body').innerHTML = message;
        switchToOkButtons();
        $('#confirmationModal').modal('show');
    }

    // currently selected proof method.
    let selectedMethod = null;

    // Lets the current method be shown as a whole phrase to the user
    var methodPhrase = {
        DM: "Direct",
        SS: "Starting from one side",
        WE: "Weakening",
        ST: "Strengthening",
        ND: "Natural Deduction",
        TR: "Transitivity",
        CO: "Contradiction",
        CR: "Counter-reciprocal",
        CA: "Case analysis",
        AI: "Conjunction by parts",
        WI: "Witness",
    };

    /*
        Opens the modal to get some confirmation from user depending on the 
        proof method selected.
        methodId: id of the proof method selected
    */
    function openModal(methodId) {
        let commonPrefix = "Are you sure you want to use the";
        let commonSufix = "Method?";
        let type = methodPhrase[methodId];

        // pick method to take actions correspondingly
        this.selectedMethod = methodId;
        $('#ok-buttons').addClass('d-none');
        $('#input_cases').addClass('d-none');
        $('#accept-cancel-buttons').removeClass('d-none');

        // build the message for the confirmation
        let message = commonPrefix + " " + type + " " + commonSufix;

        // insert the message and show the modal
        document.getElementById('modal-header').innerHTML = 'Confirmation';
        document.getElementById('modal-body').innerHTML = message;
        $('#confirmationModal').modal('show');
    }

    /*
        Sets the body of the modal with the message provided.
        text: string to be added to the body
    */
    function setModalBody(text) {
        document.getElementById('modal-body').innerHTML = text;
    }

    /*
        Hide accept/cancel buttons block and shows the ok buttons block
        to alternate between confirmation and just information modal.
    */
    function switchToOkButtons() {
        document.getElementById('modal-header').innerHTML = 'Information';
        $('#ok-buttons').removeClass('d-none');
        $('#accept-cancel-buttons').addClass('d-none');
    }

    /*
        Accepts the confirmation prompted to the user, takes an action depending
        on the proog method previously selected.
    */
    async function accept() {
        $("#selectTeoInicial").val("0");
        let message = null;
        let method = this.selectedMethod;

        switch (method){
            case "DM": // Direct method
                $("#selectTeoInicial").val("1");

                // This is what makes the theorem be clickable
                $(".teoIdName").css({"cursor":"pointer","color":"#08c"});
                $(".operator").css({"cursor":"","color":""});

                message = 'Please, select the theorem with which the proof will begin.';

                // If the AJAX is called from here, we must put the current expression as clickable.
                // The other case will be called from the view "infer.jsp"
                method = "DM Clickable"; 
                break;

            case "SS": // One-sided method
                message = 'Please, select the side from which the proof will begin.';

                // If the AJAX is called from here, we must put the current expression as clickable.
                // The other case will be called from the view "infer.jsp"
                method = "SS Clickable"; 
                break;

            case "CA": // Proof by cases method
                message = 'Please, enter the number of cases that will be proved.';
                $('#input_cases').removeClass('d-none');
                break;

            case "AI": // And introduction method
                message = "Please, select a proof method for the case.";
                break;

            case "CO": // Contradiction method
            case "CR": // Counter-reciprocal method
                message = "Please, select another method to do the sub-proof.";
                break;

            case "WE": // Weakening method
            case "ST": // Strengthening method
            case "TR": // Transitivity method
            default:
                break;
        }

        let success = await proofMethodAjax(method);

        if (success && (message!=null)){ // Case in which we must put a message
            setModalBody(message);
            switchToOkButtons();
        }
        else {
            closeModal();
        }
    }

    // Hides the modal 
    function closeModal() {
        $('#confirmationModal').modal('hide');
    }

    // Closes modal and adds formula inputs for proof by cases
    function okButton() {
        if( this.selectedMethod === "7"){
            $("#formulaInput").removeClass('d-none');
            $("#formula").addClass('d-none');
        }
        closeModal();
    }
</script>