<div class="modal fade padding" id="modalAggiungiFattorino" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<form id="formAggiungiFatt" onsubmit="aggiungiFattorino(); return false">
			<div class="modal-content" style="padding:10">
				<div class="modal-header" style="color: #333333;">
					<h5 class="modal-title" id="titolo">Aggiungi fattorino</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
			
					<div class="form-group">
						<label for="nomeFatt">Nome</label>
						<input type="text" class="form-control" id="nomeFatt" aria-describedby="emailHelp"/>
						
					</div>
					<div class="form-group">
						<label for="cognomeFatt">Cognome</label>
						<input type="text" class="form-control" id="cognomeFatt" aria-describedby="emailHelp"/>
						
					</div>
					<div class="form-group">
						<label for="emailFatt">Email</label>
						<input type="text"  class="form-control" id="emailFatt" aria-describedby="emailHelp"/>
					</div>
					<div class="form-group">
						<label for="passwordFatt">Password</label>
						<input type="password"  class="form-control" id="passwordFatt" aria-describedby="emailHelp"/>
					</div>	
					<div class="form-group">
						<label for="telefonoFatt">Telefono</label>
						<input type="text"  class="form-control" id="telefonoFatt" aria-describedby="emailHelp"/>
					</div>				
				
				
				<div class="modal-footer">
				<input id="btnAggiungiFattorino" type="submit" class="btn btn-success" value="Crea"/>

				</div>
			</div>
		</form>
		</div>
		</div>