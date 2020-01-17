<%@page import="model.beans.Prodotto"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="model.beans.Categoria"%>
<%@page import="java.util.HashSet"%>
<%@page import="model.daoFactory.CategoriaDAOFactory"%>
<%@page import="model.daoFactory.CartaDAOFactory"%>
<%@page import="model.beans.Pizzeria"%>
<div class="modal fade padding" id="modalAccesso" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalCenterTitle">Accesso Ristorante</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form id="formLogin" onsubmit="login('no'); return false">
				<div class="modal-body">
					<div class="form-group">
						<label for="username">P.IVA</label>
						<input type="text" class="form-control" id="input-username" aria-describedby="emailHelp">
					</div>
					<div class="form-group">
						<label for="password">Password</label>
						<input type="password" class="form-control" id="input-password" aria-describedby="emailHelp">
						<div class="invalid-feedback">
        					P.IVA o password errati.
      					</div>
					</div>
				</div>
				<div class="modal-footer">
					<input id="btnAccedi" type="submit" class="btn btn-success" value="Accedi"/>
				</div>
				</form>
			</div>
		</div>
</div>

<div class="modal fade padding" id="modalChangePassword" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<form onsubmit="changePassword(); return false">
			<div class="modal-content">
				<div class="modal-header" style="color: #333333;">
					<h5 class="modal-title" id="exampleModalCenterTitle">Cambio Password</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<div class="modal-body" style="color: #333333;">
					<div class="form-group">
						<label for="vecchiaPassword">Password attuale</label>
						<input type="password" class="form-control" id="vecchiaPassword" aria-describedby="emailHelp">
						<div class="invalid-feedback">
        					Password attuale errata.
      					</div>
					</div>
					<div class="form-group">
						<label for="newPassword">Nuova password</label>
						<input type="password" class="form-control" id="newPassword" aria-describedby="emailHelp">
						<div class="invalid-feedback">
        					Nuova password non valida.
      					</div>
					</div>
					
					<div class="form-group">
						<label for="confirmNewPassword">Conferma nuova password</label>
						<input type="password" class="form-control" id="confirmNewPassword" aria-describedby="emailHelp">
						<div class="invalid-feedback">
        					Email o password errati.
      					</div>
					</div>
					
				</div>
				
				<div class="modal-footer">
					<input type="submit" id="btnUpdatePassword" class="btn btn-primary" value="Aggiorna">
				</div>
			</div>
			</form>
		</div>
	</div>
	
	
	
	
	
	<div class="modal fade padding" id="modalCreateProduct" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<form id="formCreateProduct" onsubmit="aggiungiProdotto(); return false">
			<div class="modal-content">
				<div class="modal-header" style="color: #333333;">
					<h5 class="modal-title" id="titolo">Crea Prodotto</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<div class="modal-body" style="color: #333333;">
					<div class="form-group">
						<label for="createCat">Categoria</label>
						<select id="createCat">
					
						<%

						
						if (request.getSession().getAttribute("pizzeria") != null) {
							Pizzeria pizzeria = (Pizzeria) request.getSession().getAttribute("pizzeria");
						}
						HashSet<Categoria> cat = (HashSet)CategoriaDAOFactory.getCategoriaDAO().getCategorie();
						
						for(Categoria c : cat) {
							
						%>
							<option value="<%=c.getNome() %>"><%=c.getNome() %></option>
							<%} %>
						</select>
					</div>
					<div class="form-group">
						<label for="nomeProdotto">Prodotto</label>
						<input type="text" class="form-control" pattern="[a-zA-z]{2,19}" id="nomeProdotto" aria-describedby="emailHelp" required/>
						
					</div>
					<div class="form-group">
						<label for="ingredienti">Ingredienti</label>
						<input type="text" class="form-control" id="ingredienti" aria-describedby="emailHelp" pattern="^[a-zA-Z,. ]*$" required/>
						
					</div>
					<div class="form-group">
						<label for="createPrezzo">Prezzo</label>
						<input type="number"  class="form-control" id="createPrezzo" pattern="[0-9]{0.01,}" aria-describedby="emailHelp" min="0.01" step =".01" required/>
					</div>
					<div class="form-group">
						<label for="dispProdotto">Disponibilità</label>
						<select id="dispProdotto">
							<option value="si">si</option>
							<option value="no">no</option>
						</select>
					</div>
				</div>
				
				<div class="modal-footer">
				<input id="btnCreaNuovoProdotto" type="submit" class="btn btn-success" value="Crea"//>

				</div>
			</div>
			</form>
		</div>
	</div>
	
	<div class="modal fade padding" id="modalProdotto" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
		
			<form name="aggiornamento" id="formAggiornamentoProdotto" onsubmit="updateProduct(); return false">
			<div class="modal-content">
				<div class="modal-header" style="color: #333333;">
					<h5 class="modal-title" id="titolo">Modifica Prodotto</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<div class="modal-body" style="color: #333333;">
					<div class="form-group">
						<label for="nome">Nome</label>
						<input type="text" value="" class="form-control" id="nomeProd" aria-describedby="emailHelp">
						<div class="invalid-feedback">
        					Nome errato
      					</div>
					</div>
					<div class="form-group">
						<label for="nome">Ingredienti</label>
						<input type="text" value="" class="form-control" id="ingred" aria-describedby="emailHelp">
						<div class="invalid-feedback">
        					Nome errato
      					</div>
					</div>
					
					<div class="form-group">
						<label for="createCat">Categoria</label>
						<select id="cat">
					<%
						HashSet<Categoria> cate = (HashSet)CategoriaDAOFactory.getCategoriaDAO().getCategorie();
	
						for(Categoria c : cate) {
							
						%>
							<option value="<%=c.getNome() %>"><%=c.getNome() %></option>
							<%} %>
						</select>
					</div>
					<div class="form-group">
						<label for="disp">Disponibilità</label>
      						<select class="form-control" id="dispProd">
       							 <option value="si">Disponibile</option>
       							 <option value="no">Non Disponibile</option>
      				      </select>
					</div>
					
					<div class="form-group">
						<label for="prezzo">Prezzo</label>
						<input type="number" step="0.01"class="form-control" id="prezzo" aria-describedby="emailHelp">
						<div class="invalid-feedback">
        					Non valido.
      					</div>
					</div>
					
				</div>
				
				<div class="modal-footer">
				<input id="btnAggiornaProdotto" type="submit" class="btn btn-success" value="Aggiorna"/>

				</div>
			</div>
			</form>
		</div>
	</div>
	
	<div class="modal fade padding" id="modalFattorino" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
		
			<form name="aggiornamentoFattorino" id="formAggiornamentoFattorino" onsubmit="updateFattorino(); return false">
			<div class="modal-content">
				<div class="modal-header" style="color: #333333;">
					<h5 class="modal-title" id="titolo">Modifica Fattorino</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<div class="modal-body" style="color: #333333;">
					<div class="form-group">
						<label for="nome">Nome</label>
						<input type="text" value="" class="form-control" id="nomeFattorino" aria-describedby="emailHelp">
						<div class="invalid-feedback">
        					Nome errato
      					</div>
					</div>
					<div class="form-group">
						<label for="nome">Cognome</label>
						<input type="text" value="" class="form-control" id="cognomeFattorino" aria-describedby="emailHelp">
						<div class="invalid-feedback">
        					Cognome errato
      					</div>
					</div>
					<div class="form-group">
						<label for="nome">Email</label>
						<input type="text" value="" class="form-control" id="emailFattorino" aria-describedby="emailHelp">
						<div class="invalid-feedback">
        					Email errato
      					</div>
					</div>
					
					<div class="form-group">
						<label for="nome">Telefono</label>
						<input type="text" value="" class="form-control" id="telefonoFattorino" aria-describedby="emailHelp">
						<div class="invalid-feedback">
        					Telefono errato
      					</div>
					</div>
					
				</div>
				
				<div class="modal-footer">
				<input id="btnAggiornaFattorino" type="submit" class="btn btn-success" value="Aggiorna"/>

				</div>
			</div>
			</form>
		</div>
	</div>
	
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
						<input type="text" class="form-control" id="nomeFatt" aria-describedby="emailHelp" pattern="[a-zA-z]{2,19}" required/>
						
					</div>
					<div class="form-group">
						<label for="cognomeFatt">Cognome</label>
						<input type="text" class="form-control" id="cognomeFatt" aria-describedby="emailHelp" pattern="[a-zA-z]{2,29}" required/>
						
					</div>
					<div class="form-group">
						<label for="emailFatt">Email</label>
						<input type="text"  class="form-control" id="emailFatt" aria-describedby="emailHelp" pattern="^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$" required/>
					</div>
					<div class="form-group">
						<label for="passwordFatt">Password</label>
						<input type="password"  class="form-control" id="passwordFatt" aria-describedby="emailHelp" pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{5,}" required/>
					</div>	
					<div class="form-group">
						<label for="telefonoFatt">Telefono</label>
						<input type="text"  class="form-control" id="telefonoFatt" aria-describedby="emailHelp" pattern="[0-9]{9,14}" required/>
					</div>				
				
				
				<div class="modal-footer">
				<input id="btnAggiungiFattorino" type="submit" class="btn btn-success" value="Crea"/>

				</div>
			</div>
		</form>
		</div>
		</div>
	