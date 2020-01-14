
<%@page import="model.daoFactory.PizzeriaDAOFactory"%>
<%@page import="model.beans.Pizzeria"%>
<%@page import="model.beans.Utente"%>
<%@page import="java.util.Set"%>
<% Pizzeria pizzeria = (Pizzeria) session.getAttribute("pizzeria");
	Set<Utente> fattorini = (Set<Utente>)PizzeriaDAOFactory.getPizzeriaDAO().getFattorini(pizzeria.getPartitaIva());
%>
<div class="row product-row first-row-cat">
		<div class="col-4 col-md-2 col-lg-2"> <p>Nome</p></div>
		<div class="col-2 col-md-2 col-lg-2">Cognome</div>
		<div class="col-3 col-md-3 col-lg-3">Email</div>
		<div class="col-3 col-md-3 col-lg-3">Telefono</div>
</div>
<%for(Utente u: fattorini){ %>
<div class="row product-row nomeProdotto">
		<div class="col-2 col-md-2 col-lg-2" style=text-align:center> <p><%=u.getNome() %></p></div>
		<div class="col-2 col-md-2 col-lg-2" style="text-align:center"><p><%=u.getCognome()%></p></div>
		<div class="col-2 col-md-3 col-lg-3" style="text-align:center"><p><%=u.getEmail() %></p></div>
		<div class="col-2 col-md-3 col-lg-3" style="text-align:center"><p><%=u.getTelefono() %></p></div>
		
		<div class="col-2 col-md-2 col-lg-2" style="text-align:center">
		<i onClick="settingsFattorino('<%=u.getNome()%>','<%=u.getCognome()%>','<%=u.getEmail()%>','<%=u.getTelefono()%>');"		
			id="account-icon" class="material-icons" style="margin-top:10px;">settings</i>
			<i onClick="deleteFattorino('<%=u.getEmail()%>')" class="material-icons" id="delete-cart" style="margin-top:10px;"> delete</i>
		</div>
	</div>
	<%} %>
	<div class="row w-100 mt-4 mb-3">
		<div class="col-xl-12">
			<button class="btn btn-success"onClick="visualizzaModalAggiungiFattorino();" style="width: 50%;  margin-left: 25%; font-size: 1.3em;
			 box-shadow:0px 10px 10px 1px rgb(0, 0, 0,1);" id="btnAddProd">Aggiungi un nuovo Fattorino</button>
		</div>
	</div>