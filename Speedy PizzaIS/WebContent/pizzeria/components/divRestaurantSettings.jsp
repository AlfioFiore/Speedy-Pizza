<%@page import="model.beans.Pizzeria"%>
<%Pizzeria p = (Pizzeria)request.getSession().getAttribute("pizzeria"); 
	
	int id = -1;
	if(p.getIndirizzo()!=null){
		id = p.getIndirizzo().getIdIndirizzo();	
	}
%>
<div class="card w-100 div-settings" style="width: 18rem; height:auto;">
	<div class="card-header" style="background-color: #333333; border-bottom: 1px solid #F2C337;">
		<p>Impostazioni</p>
	</div>
		<div class="card-body" style="padding: 0px;">


<form onsubmit="updateInformazioni('<%=id%>'); return false">
<div class="form-group" style="margin-top: 5vh;">
	<h3 style="color: green;">Partita Iva</h3>
	<input type="text" class="form-control input-bordered" id="pIva" <%if (p.getPartitaIva()!=null){ %>value=<%=p.getPartitaIva()%><%} %> style="width: 90%;" required>
		<div class="invalid-feedback">
        	Partita iva non valida
      	</div>
</div>
<div class="form-group">
	<h3 style="color: green;">Nome Ristorante</h3>
	<input type="text" class="form-control input-bordered" id="nomeRist" <%if (p.getNome()!=null){ %>value=<%=p.getNome()%><%} %> style="width: 90%;" required>
		<div class="invalid-feedback">
        	Nome non valido
      	</div>
</div>
<div class="form-group">
	<h3 style="color: green;">Iban</h3>
	<input type="text" class="form-control input-bordered" id="iban" <%if (p.getIban()!=null){ %>value=<%=p.getIban()%><%} %> style="width: 90%;" required>
		<div class="invalid-feedback">
        	Iban non valido
      	</div>
</div>
<div class="form-group">
	<h3 style="color: green;">Orario apertura</h3>
	<input type="time"  class="form-control input-bordered" id="orarioApertura" <%if(p.getOrarioApertura()!=null){%>value=<%=p.getOrarioApertura()%><%} %> style="width: 90%;" required>
		<div class="invalid-feedback">
        	Orario non valido
      	</div>
</div>

<div class="form-group">
	<h3 style="color: green;">Orario chiusura</h3>
	<input type="time"  class="form-control input-bordered" id="orarioChiusura"<%if(p.getOrarioChiusura()!=null){%>value=<%=p.getOrarioChiusura()%><%} %> style="width: 90%;" required>
		<div class="invalid-feedback">
        	Orario non valido
      	</div>
</div>

<div class="row" style="margin-bottom: 5vh;">
<div class="col-sm-12" >

<h3 style="color: green;">Giorni apertura</h3>
</div>
	<div class="col">
		<label for="giorniApertura" style="margin-left: 4vw; margin: 0">lun</label>
		<input value="lun" <%if(p.getGiorniApertura()!= null && p.getGiorniApertura().contains("lun")) {%> checked="checked"<%} %> id="lunApertura" type="checkbox" class="form-control input-bordered" name="giorniApertura" style="width: 10vw; height: 10vh; " >
	</div>
	<div class="col">
		<label for="giorniApertura" style="margin-left: 4vw; margin: 0">mar</label>
		<input id="marApertura"  <%if(p.getGiorniApertura()!= null && p.getGiorniApertura().contains("mar")) {%> checked="checked"<%} %>type="checkbox" class="form-control input-bordered" name="giorniApertura" style="width: 10vw; height: 10vh;" value="mar">
	</div>
	<div class="col">
		<label for="giorniApertura" style="margin-left: 4vw; margin: 0">mer</label>
		<input  id="merApertura" <%if(p.getGiorniApertura()!= null && p.getGiorniApertura().contains("mer")) {%> checked="checked"<%} %>type="checkbox" class="form-control input-bordered" name="giorniApertura" style="width: 10vw; height: 10vh; " value="mer">
	</div>
	
	<div class="col">
		<label for="giorniApertura" style="margin-left: 4vw; margin: 0">gio</label>
		<input  id="gioApertura" <%if(p.getGiorniApertura()!= null && p.getGiorniApertura().contains("gio")) {%> checked="checked"<%} %>type="checkbox" class="form-control input-bordered" name="giorniApertura" style="width: 10vw; height: 10vh; " value="gio">
	</div>
	<div class="col">
		<label for="giorniApertura" style="margin-left: 4vw; margin: 0">ven</label>
		<input  id="venApertura" <%if(p.getGiorniApertura()!= null && p.getGiorniApertura().contains("ven")) {%> checked="checked"<%} %>type="checkbox" class="form-control input-bordered" name="giorniApertura" style="width: 10vw; height: 10vh;" value="ven">
	</div>
	<div class="col">
		<label for="giorniApertura" style="margin-left: 4vw; margin: 0">sab</label>
		<input  id="sabApertura" <%if(p.getGiorniApertura()!= null && p.getGiorniApertura().contains("sab")) {%> checked="checked"<%} %>type="checkbox" class="form-control input-bordered" name="giorniApertura" style="width: 10vw; height: 10vh; " value="sab">
	</div>
	<div class="col">
		<label for="giorniApertura" style="margin-left: 4vw; margin: 0">dom</label>
		<input id="domApertura"<%if(p.getGiorniApertura()!= null && p.getGiorniApertura().contains("dom")) {%> checked="checked"<%} %> type="checkbox" class="form-control input-bordered" name="giorniApertura" style="width: 10vw; height: 10vh; " value="dom">
	</div>
	
	
		
</div>

<div class="form-group">
	<h3 style="color: green;">Città</h3>
	<input type="text" class="form-control input-bordered" id="citta" <%if(p.getIndirizzo()!=null){%>value=<%=p.getIndirizzo().getCitta()%><%} %> style="width: 90%;" required>
		<div class="invalid-feedback">
        	Città non valida
      	</div>
</div>

<div class="form-group">
	<h3 style="color: green;">Via</h3>
	<input type="text" class="form-control input-bordered" id="indirizzo" <%if(p.getIndirizzo()!=null){%>value=<%=p.getIndirizzo().getVia()%><%} %> style="width: 90%;" required>
		<div class="invalid-feedback">
        	Via non valida
      	</div>
</div>
<div class="form-group">
	<h3 style="color: green;">Cap</h3>
	<input type="text" class="form-control input-bordered" id="cap" <%if(p.getIndirizzo()!=null){%>value=<%=p.getIndirizzo().getCap()%><%} %> style="width: 90%;" required>
		<div class="invalid-feedback">
        	Cap non valido
      	</div>
</div>
<div class="form-group">
	<h3 style="color: green;">Civico</h3>
	<input type="text" class="form-control input-bordered" id="civico" <%if(p.getIndirizzo()!=null){%>value=<%=p.getIndirizzo().getCivico()%><%} %> style="width: 90%;" required>
		<div class="invalid-feedback">
        	Civico non valido
      	</div>
</div>





<div class="col-xl-12" style="margin-top: 5vh;">
	<input type="submit" value="Aggiorna" class="btn btn-outline-warning" style="width: 90%; font-size: 1.2em; border: 2px solid #F2C337;">
</div>
</form>
<div class="col-xl-12">
	<button id="btn-change-password" onclick="modalCambiaPassword()" class="btn btn-outline-danger" style="width: 90%; font-size: 1.2em; margin-bottom: 2vh; border: 2px solid #dc3545;">Cambia password</button>
</div>
</div>
</div>

	<div class="modal fade" id="modalChangePasswordRisto" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" style="padding-left:20%">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<form onsubmit="cambiaPasswordPizzeria(); return false">
			<div class="modal-content">
				<div class="modal-header" style="color: #333333;">
					<h5 class="modal-title" id="exampleModalCenterTitle">Cambio Password</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<div class="modal-body" style="color: #333333;">
					<div class="form-group">
						<label for="vecchiaPassword">Password attristouale</label>
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
