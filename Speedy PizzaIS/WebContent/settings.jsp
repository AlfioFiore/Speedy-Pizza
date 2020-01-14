<%@page import="model.beans.Utente" %>
<%
Utente x = null;
if (request.getSession().getAttribute("utente") != null) {
	x = (Utente) request.getSession().getAttribute("utente");
	if(x.getTipo() !=0){
	
		response.sendRedirect("index.jsp");
	}
}else{
	response.sendRedirect("index.jsp");
}
%>

	<div class="card w-100 div-settings" style="width: 18rem;">
  		<div class="card-header" style="background-color: #333333; border-bottom: 1px solid #F2C337;">
  			Ciao, <%= x.getNome() %> <%= x.getCognome()%>
  		</div>
  		<div class="card-body" style="padding: 0px;">
		<ul class="list-group list-group-flush w-100 ul-settings">
  			<li onclick="showSpecifiedSetting('accountSettings');" id="accountSettings" class="list-group-item" style="background-color: #333333; border-bottom: 2px solid #F2C337;">Impostazioni Account</li>
  			<li onclick="showSpecifiedSetting('myOrders');" id="myOrders" class="list-group-item" style="background-color: #333333; border-bottom: 2px solid #F2C337;">I Miei Ordini</li>
  			<li onclick="showSpecifiedSetting('address');" id="address" class="list-group-item" style="background-color: #333333; border-bottom: 2px solid #F2C337;">Indirizzi</li>
  			<li onclick="showSpecifiedSetting('paymentMethod');" id="paymentMethod" class="list-group-item" style="background-color: #333333">Metodi di pagamento</li>
		</ul>
		</div>
	</div>
