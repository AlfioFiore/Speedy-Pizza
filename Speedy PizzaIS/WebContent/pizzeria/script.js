
function openAccount() {
	$('#modalAccesso').modal('show');
}


function ristoOrdini(what, param){
	site = "";
	if (param != "") site = "components/divOrders.jsp?"+param;
	else site = "components/divOrders.jsp";
	$("#contenutoPagina").hide().load(site, function(){
		$(".orderStateSelect").change(function(){
			var st = $(this).val();
			var order = $(this).attr("ordine");
			$.ajax({
				url:'../OrdineServlet',
				type:"POST",
				data:{
					method: 'aggiornaStato',
					idOrdine : order,
					stato : st
				},
				success: function(result){
					ristoOrdini('ordini', '');
				}
			});
		});
		$("#whatShow").change(function(){
			var what = $(this).val();
			ristoOrdini('ordini', 'show='+what);
		});
		$("#btnCercaOrdiniDate").click(function(){
			var from = $("#ordiniDal").val();
			var to = $("#ordiniAl").val();
			var str = 'dal='+from+'&al='+to;
			ristoOrdini('ordini', str);
		});
}).fadeIn('500');
}


function ristoImpostazioni(){
	
	$("#contenutoPagina").load('components/divRestaurantSettings.jsp');
	
}

function updateInformazioni(id) {
	
	
	//per ottenere i giorni scelti sotto forma di stringa
	var daySelected = [];
    $.each($("input[name='giorniApertura']:checked"), function(){            
        daySelected.push($(this).val());
    });
    var day = daySelected.join("\+");
    var pizzeria = {
    		partitaIva : $("#pIva").val(),
			nome : $("#nomeRist").val(),
			orarioApertura : $("#orarioApertura").val(),
			orarioChiusura : $("#orarioChiusura").val(),
			giorniApertura : day,
			iban : $("#iban").val(),
			indirizzo : {
				idIndirizzo : id,
				via : $("#indirizzo").val(),
				citta : $("#citta").val(),
				cap :	$("#cap").val(),
				civico : $("#civico").val(),
				
			}
    };
   
    $.ajax({
    		url: "../InformazioniServlet",
    		type:"POST",
    		data:{
    			method : 'aggiornaImpostazioni',
    			pizzeria :JSON.stringify(pizzeria)
    		},
    		success: function(result){
    			ristoImpostazioni()
    		},
    		error: function() {
    			//do nothing
    		}
    	});
    
}

function ristoCatalogo(){
	$("#contenutoPagina").load('components/divCatalogo.jsp');
		
}
function visualizzaFattorini(){
	$("#contenutoPagina").load('components/divFattorini.jsp');
}
function logout() {
	
	$.ajax({
		url : '../AutenticazioneServlet',
		type: "POST",
		data:{
			method: 'logout'
		},
		success : function() {
			
			location.reload();
		}
	});
}

function aggiungiProdotto() {

 var prod = {
    		nome : $("#nomeProdotto").val(),
			ingredienti : $("#ingredienti").val(),
			prezzo : $("#createPrezzo").val(),
			disponibilita : $("#dispProdotto").val(),
			idPizzeria : ""};
var categoria = {
				nome : $("#createCat").val(),
				iva : 0
			
    };	

	$.ajax({
		url : '../CatalogoServlet',
		type: "POST",
		data : {
			method : 'aggiungiProdotto',
			prodotto : JSON.stringify(prod),
			categoria : JSON.stringify(categoria)
		},
		success : function() {
			//alert("inserito");			
			$("#modalCreateProduct").modal('hide');
			ristoCatalogo()
		},
		error: function() {
			alert("prodotto gia' esistente");
		}
	});	

}

function deleteProduct(nome){
	$.ajax({
		url : '../CatalogoServlet',
		type: "POST",
		data : {
			method : "eliminaProdotto",
			nome: nome
		},
		success : function(result) {
			ristoCatalogo();
		}
	});	

}
function visualizzaModalAggiungiFattorino(){
	$('#modalAggiungiFattorino').modal('show');
}
function aggiungiFattorino(){
	var utente={
			nome : $("#nomeFatt").val(),
			cognome:$("#cognomeFatt").val(),
			email:$("#emailFatt").val(),
			password : $("#passwordFatt").val(),
			telefono:$("#telefonoFatt").val(),
			tipo: 2
	};
	$.ajax({
		url : '../ManagerFattorinoServlet',
		type: "POST",
		data : {
			
			method : 'aggiungiFattorino',
			fattorino : JSON.stringify(utente)
			
		},
		success : function() {
			alert("aggiunto");			
			$("#modalAggiungiFattorino").modal('hide');
			visualizzaFattorini()
		},
		error: function() {
			alert("impossibile aggiungere");
		}
	});	
}
function deleteFattorino(email){
	$.ajax({
		url : '../ManagerFattorinoServlet',
		type: "POST",
		data : {
			method : "eliminaFattorino",
			email: email
		},
		success : function(result) {
			visualizzaFattorini();
		},
		error: function() {
			alert("impossibile eliminare");
		}
	});	

}

function settingsFattorino(nome,cognome,email,telefono){
	
	$('#modalFattorino').modal('show');
	$("form[name='aggiornamentoFattorino']").attr('onsubmit',"updateFattorino("+"'"+email+"'"+"); return false");	
		$("#nomeFattorino").val(nome);
		$("#cognomeFattorino").val(cognome);
		$("#emailFattorino").val(email);
		$("#telefonoFattorino").val(telefono);
		

}

function settingsProduct(nome,ingredienti,prezzo,disp,cat){
	
	$('#modalProdotto').modal('show');
	$("form[name='aggiornamento']").attr('onsubmit',"updateProduct("+"'"+nome+"'"+"); return false");	
		$("#nomeProd").val(nome);
		$("#ingred").val(ingredienti);
		$("#dispProd").val(disp);
		$("#prezzo").val(prezzo);
		$("#cat").val(prezzo);

}

function visualizzaModalAggiungiProdotto(){
	$("#modalCreateProduct").modal('show');
}
function modalCambiaPassword(){
	$('#modalChangePassword').modal('show');

}
function changePassword(){
	if($("#vecchiaPassword").val() ==""){
		alert("Password richiesta");
		
		return false
	}else if($("#vecchiaPassword").val()==$("#newPassword").val()){
		alert("nuova e vecchia password coincidono")
		return false
	}
	else if($("#newPassword").val() != $("#confirmNewPassword").val())	
	{
		alert("le password non coincidono")
		
		return false
	}
	else if($("#newPassword").val() =="" ){
		alert("Nuova password richiesta");
		
		return false
	}
	else if($("#confirmNewPassword").val() =="" ){
		alert("Conferma password richiesta");
		
		return false
	}else{
	return $.ajax({
		url : '../ImpostazioniServlet',
		type: "POST",
		data : {
			
			method : 'cambiaPassword',
			vecchiaPassword : $("#vecchiaPassword").val(),
			nuovaPassword : $("#newPassword").val(),
			confermaNuovaPassword : $("#confirmNewPassword").val()
		},
		success : function(result) {
			alert("Password modificata");
			return true;
		},
		error : function(result) {
			alert('Impossibile modificare.');
			return false;
		}
	});
	}
	
}
function updateFattorino(oldEmail){
	var utente={
			nome : $("#nomeFattorino").val(),
			cognome:$("#cognomeFattorino").val(),
			email:$("#emailFattorino").val(),
			telefono:$("#telefonoFattorino").val()
	};
	$.ajax({
		url : '../ManagerFattorinoServlet',
		type: "POST",
		data : {
			vecchio : oldEmail,
			method : 'aggiornaFattorino',
			fattorino : JSON.stringify(utente)
			
		},
		success : function() {
			alert("aggiornato");			
			$("#modalFattorino").modal('hide');
			visualizzaFattorini()
		},
		error: function() {
			alert("impossibile aggiornare");
		}
	});		

	
}
function updateProduct(old){
	
	var prod = {
		nome : $("#nomeProd").val(),
		ingredienti : $("#ingred").val(),
		prezzo : $("#prezzo").val(),
		disponibilita : $("#dispProd").val(),
		idPizzeria : ""
	};
	var categoria = {
		nome : $("#cat").val(),
		iva : 0
	 };
	
	$.ajax({
		url : '../CatalogoServlet',
		type: "POST",
		data : {
			vecchio : old,
			method : 'aggiornaProdotto',
			prodotto : JSON.stringify(prod),
			categoria : JSON.stringify(categoria)
		},
		success : function() {
			alert("aggiornato");			
			$("#modalProdotto").modal('hide');
			ristoCatalogo()
		},
		error: function() {
			alert("prodotto gia' esistente");
		}
	});		

}