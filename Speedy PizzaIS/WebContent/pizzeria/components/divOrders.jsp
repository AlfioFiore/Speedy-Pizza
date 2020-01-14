<%@page import="java.util.Iterator"%>
<%@page import="java.util.Map"%>
<%@page import="model.beans.Prodotto"%>
<%@page import="java.util.HashMap"%>
<%@page import="model.beans.Carrello"%>
<%@page import="model.daoFactory.OrdineDAOFactory"%>
<%@page import="model.beans.Ordine"%>
<%@page import="java.util.Set"%>
<%@page import="model.beans.Pizzeria"%>
<div class="row mb-3 align-center w-100 ">
<div class="col-6">
	<%
	String what = "";
	if (request.getParameter("show") != null && request.getParameter("show").equals("sospesi")) {
		what = "sospesi";%>
		Mostra: <select id="whatShow"><option value="tutti">tutti</option><option value="sospesi" selected>sospesi</option></select>
	<%} else if ((request.getParameter("show") != null && request.getParameter("show").equals("tutti")) || request.getParameter("show") == null) { 
		what = "tutti";%>
		Mostra: <select id="whatShow"><option value="tutti" selected>tutti</option><option value="sospesi" >sospesi</option></select>	
	<%} else {
		 response.sendRedirect("../indexPizzeria.jsp");
	}
	%>
	
</div>
<div class="col-6">
Dal:<input type="date" id="ordiniDal">
Al: <input type="date" id="ordiniAl">
<button class="btn btn-outline-success" id="btnCercaOrdiniDate">Cerca</button>
</div>
</div>

<div class="row product-row first-row">
	<div class="col-1 col-md-1 col-lg-1" style="padding-left:5px !important;">Ordine N.</div>
	<div class="col-1 col-md-1 col-lg-1">Stato</div>
	<div class="col-3 col-md-3 col-lg-3">Cliente</div>
	<div class="col-1 col-md-1 col-lg-1" style="padding-left:0px !important;">Prezzo</div>
	<div class="col-1 col-md-1 col-lg-1">Pagamento</div>
	<div class="col-3 col-md-4 col-lg-4" style="padding-left:30px !important; padding-right:0px !important;">Data</div>
	<div class="col-1 col-md-1 col-lg-1" style="padding-left:5px !important;">Tipo</div>
</div>

<%
Pizzeria pizzeria = null;
if (request.getSession().getAttribute("pizzeria") != null) {
	pizzeria = (Pizzeria) request.getSession().getAttribute("pizzeria");
} else {
	response.sendRedirect("/indexPizzeria.jsp");
}
Set<Ordine> ordini = (Set<Ordine>)OrdineDAOFactory.getOrdineDAO().getOrdiniByPizzeria(pizzeria.getPartitaIva());


	
for (Ordine or : ordini) {
	
	String state = or.getStato();
	String toPrintt="";
	 switch(state) {
	 case "Elaborazione ordine":
		 toPrintt="<option value='Ricevuto'>Ricevuto</option><option value='Preso in carico'>Preso in carico</option><option value='In lavorazione'>In lavorazione</option><option value='In consegna'>In Consegna</option><option value='Consegnato'>Consegnato</option>";
		 break;
	 case "Preso in carico":
		 toPrintt="<option value='Preso in carico'>Preso in carico</option><option value='In preparazione'>In preparazione</option><option value='In consegna'>In Consegna</option><option value='Consegnato'>Consegnato</option>";
		 break;
	 case "In lavorazione":
		 toPrintt="<option value='In '>In lavorazione</option><option value='In consegna'>In Consegna</option><option value='Consegnato'>Consegnato</option>";
		 break;
	 case "In consegna":
		 toPrintt="<option value='In consegna'>In Consegna</option><option value='Consegnato'>Consegnato</option>";
		 break;
	 case "Consegnato":
		 toPrintt="<option value='100'>Consegnato</option>";
		 break;
	 }
	 int tipo = or.getTipoPagamento();
	String tipoPagamento="";
	switch(tipo){
	case 0:
		tipoPagamento="Carta";
		break;
	case 1:
		tipoPagamento="Contanti";
		break;
	}
	String tipoOrdine="";
	int tipoOr=or.getTipoOrdine();
	switch(tipoOr){
	case 0:
		tipoOrdine="Consegna a domicilio";
		break;
	case 1:
		tipoOrdine="Ritiro in pizzeria";
		break;
	}
	%>
	
<div class="row order-row product-row <%=or.getId() %>" data-toggle="collapse" href="#div<%=or.getId()%>" role="button" aria-expanded="false" aria-controls="collapseExample">
	<div class="col-1 col-md-1 col-lg-1"> <p><%=or.getNumeroOrdine()%> </p></div>
	<div class="col-1 col-md-1 col-lg-1">
		<select class="orderStateSelect" style="z-index: +2;" ordine="<%=or.getId()%>">
			<%=toPrintt%>
		</select>
	</div>
	<div class="col-3 col-md-3 col-lg-3"> <p><%=or.getCliente().getNome()%> <%=or.getCliente().getCognome()%></p></div>
	<div class="col-1 col-md-1 col-lg-1"> <p>&euro;  <%=or.getTotale()%></p></div>
	<div class="col-1 col-md-1 col-lg-1"> <p><%=tipoPagamento%></p></div>
	<div class="col-3 col-md-4 col-lg-4"> <p><%=or.getData()%></p></div>
	<div class="col-1 col-md-1 col-lg-1" style="padding-left:0px !important;" > <p><%=tipoOrdine%></p></div>
	
	<div class="collapse row row-p" id="div<%=or.getId()%>">
		
		<%
		String ref="";
		Carrello c = or.getCarrello();
		HashMap<Prodotto,Integer> map= (HashMap<Prodotto,Integer>) c.getProdotti();
		Iterator<Map.Entry<Prodotto, Integer>> itr = c.getProdotti().entrySet().iterator();
		
		while(itr.hasNext()) {
			Map.Entry<Prodotto, Integer> entry = itr.next();
			Prodotto p = entry.getKey();
			
			int value = entry.getValue();
			%>
		
			
			
			<div class="row row-p">
	 			<div class="col-5 col-md-2 col-lg-2"> <p><%=value%>  <%=p.getNome()%></p></div>
				<div class="col-3 col-md-2 col-lg-2"> <p><%=p.getCategoria().getNome()%></p></div>
				<div class="col-1 col-md-1 col-lg-3"> <p><%=p.getCategoria().getIva()%>  &percnt;</p></div>
				<div class="col-2 col-md-2 col-lg-3"> <p>&euro;<%=value*p.getPrezzo()%></p></div>				
			</div>
			
		
	
		<% } %>

	<div class="row">
		<div class="col-12" style="color: red;">
		Consegnare a: <%=or.getIndirizzo().toString() %>
		</div>
	</div>	
</div>
<%} %>
</div>
<div class="w-100 mb-5"></div>
