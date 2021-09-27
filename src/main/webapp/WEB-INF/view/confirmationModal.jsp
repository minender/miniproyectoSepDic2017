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

	/*
		Opens the moda to get some confirmation from user depending on the 
		proof method selected.
		methodId: id of the proof method selected
	*/
	function openModal(methodId) {

		// variables inicialization
		let commonPrefix = "Are you sure you want to use the";
		let commonSufix = "Method?";
		let type = null;

		// pick method to take actions correspondingly
		this.selectedMethod = methodId;
		$('#ok-buttons').addClass('d-none');
		$('#input_cases').addClass('d-none');
		$('#accept-cancel-buttons').removeClass('d-none');

		// pick type
		if(methodId === "DM") { // direct method
			type = "Direct";
		} else if (methodId === "SS") { // one-sided method
			type = "Starting from one side";
		} else if (methodId === "WE") { // weakening method
			type = "Weakening";
		} else if (methodId === "ST") { // strengthening method
			type = "Strengthening";
		} else if (methodId === "ND") { // transitivity method
			type = "Natural Deduction"; 
                } else if (methodId === "TR") { // transitivity method
			type = "Transitivity";
		} else if (methodId === "CO") { // proof by cases method
			type = "Contradiction";
		} else if (methodId === "CR") { // proof by cases method
			type = "Counter-reciprocal";
		} else if (methodId === "CA") { // proof by cases method
			type = "Case analysis";
		} else if (methodId === "AI") { // And introduction method
			type = "And introduction"
		} else if (methodId === "WI") { // And introduction method
			type = "Witness"
		}

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
	function accept() {
		// pick type
		if(this.selectedMethod === "DM") { // direct method
			$("#selectTeoInicial").val("1");

			// sets the body of the modal
			let message = 'Select the theorem with which the proof will begin.';
			setModalBody(message);

			$(".teoIdName").css({"cursor":"pointer","color":"#08c"});
			$(".operator").css({"cursor":"","color":""});
			$("#metodosDiv").hide();
                        teoremaClickeableMD();

			// switch to information modal
			switchToOkButtons();

		} else if (this.selectedMethod === "SS") { // one-sided method
			
			$("#selectTeoInicial").val("0");

			// sets the body of the modal
			let message = 'Select the side where the proof will start.';
			setModalBody(message);

			$("#metodosDiv").hide();
			$("#currentTeo").hide();
			teoremaClickeablePL();

			switchToOkButtons();

		} else if (this.selectedMethod === "WE") { // weakening method
			
			$("#selectTeoInicial").val("0");
			$("#metodosDiv").hide();
			$("#currentTeo").hide();
			metodoD();

			this.selectedMethod = null;
			closeModal();

		} else if (this.selectedMethod === "ST") { // strengthening method

			$("#selectTeoInicial").val("0");
			$("#metodosDiv").hide();
			$("#currentTeo").hide();
			metodoF();

			this.selectedMethod = null;
			closeModal();

		} else if (this.selectedMethod === "TR") { // transitivity method
			
			$("#selectTeoInicial").val("0");
			$("#metodosDiv").hide();
			$("#currentTeo").hide();
			transMethod();

			this.selectedMethod = 1;
			closeModal();

		}  else if (this.selectedMethod === "CR") { // weakening method
			
			$("#selectTeoInicial").val("0");
			$("#metodosDiv").hide();
			$("#currentTeo").hide();
			CRMethod();

			this.selectedMethod = null;
			closeModal();

		}  else if (this.selectedMethod === "CA") { // proof by cases method

			let message = 'Enter the number of cases that will be proved.';
			setModalBody(message);

			$("#selectTeoInicial").val("0");
			$("#metodosDiv").hide();
			$("#currentTeo").hide();

			switchToOkButtons();
			$('#input_cases').removeClass('d-none');

		} else if (this.selectedMethod === "AI") { // and introduction method
                    
			$("#metodosDiv").hide();
			$("#currentTeo").hide();
			iniAndI();

			this.selectedMethod = null;
			$('#metodosDemostracion').val("0");
			let message = "Please, select a proof method for the case.";
			document.getElementById('modal-body').innerHTML = message;
			switchToOkButtons();

		} else {
			closeModal();
		}
	}

	/*
		Hides the modal 
	*/
	function closeModal() {
		$('#confirmationModal').modal('hide');
	}

	/*
	 Closes modal and adds formula inputs for proof by cases
	*/
	function okButton() {
		if( this.selectedMethod === "7"){
			$("#formulaInput").removeClass('d-none');
			$("#formula").addClass('d-none');
		}
		closeModal();
	}
</script>