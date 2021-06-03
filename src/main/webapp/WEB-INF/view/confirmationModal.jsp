<!-- Modal -->
<div class="modal fade" id="confirmationModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content" style="width: 450px;">
			<div class="modal-header">
				Confirmation
			</div>
			<div class="modal-body" id="modal-body">  
				
			</div>
			<div class="modal-footer" style="padding: 8px;">
				<div class="row">
					<div class="col-md-6">
						<button type="button" class="btn btn-danger" onclick="cancel()">Cancel</button>
					</div>
					<div class="col-md-6">
						<button type="button" class="btn btn-success" onclick="accept()">Accept</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
        
<!-- Modal Trigger Function -->
<script type="text/javascript">
	function openModal(type, prefix, sufix) {
		let message = prefix + " " + type + " " + sufix;
		document.getElementById('modal-body').innerHTML = message;
		$('#confirmationModal').modal('show');
	}

	function accept() {
		console.log('accept!');
		$('#confirmationModal').modal('hide');
	}

	function cancel() {
		console.log('cancel!');
		$('#confirmationModal').modal('hide');
	}
</script>