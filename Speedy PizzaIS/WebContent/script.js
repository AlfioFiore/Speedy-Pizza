$(document).ready(function() {
		$.ajax({
			url : 'InformazioniServlet',
			type: "POST",
			data : {
				method : 'getAllCity',
			},
			success : function(responseText) {
				responseText.forEach(function(element) {
					$("#list-citta").append($("<option>").attr('value', element).text(element));
				});
			}
		});
	});

$('#carouselExampleIndicators').on('slid.bs.carousel', function () {
	  var numero = $('.recensione-tot.active').attr('recensione');
	  $(".change").removeClass("change-active");
	  $("#recensione"+numero).addClass("change-active");
	})


function openAccount(option) {
	$('#modalAccesso').modal('show');
	if (option == "yes") {
		$("#formLogin").attr("onsubmit" ,"login('yes'); return false");
	}
}

function apriModalChange() {
	$('#modalChangePassword').modal('show');
}


function showAddAddress() {
	$("#modalAddAddress").modal('show');
}
function showAddPaymentMethod() {
	$("#modalAddPaymentMethod").modal('show');
}

function openRegistrazione() {
	$('#modalAccesso').modal('hide');
	$('.navbar-collapse').collapse('hide');
	$('#contenutoPagina').hide().load('components/divRegistrazione.jsp').fadeIn('500');
}

function login() {
    $.ajax({
		url : 'AutenticazioneServlet',
		type: "POST",
		data : {
			method: 'login',
			email : $('#input-username').val(),
			password : $('#input-password').val()
		},
		success : function(responseText) {
			if(responseText == "cliente"){
				$("#account-icon").text('settings');
				$("#account-icon").after('\n<i onclick=\"logout();\" id=\"logout-icon\" class=\"material-icons\" style=\"margin-right: 2vw;\">logout </i>');
				$('#modalAccesso').modal('toggle');
				$("#account-icon").attr('onclick', 'showSettings()');
				$('.navbar-collapse').collapse('hide');
				
			}else if(responseText == "pizzeria"){
				location.href = "pizzeria/indexPizzeria.jsp";
				
			}else if(responseText == "fattorino"){
				location.href="fattorino/indexFattorino.jsp";
				
			}else if(responseText == "gestore"){
				
				location.href="gestore/indexGestore.jsp";
			}
		},
		error: function()	{
			$('#input-username').addClass('is-invalid');
			$('#input-password').addClass('is-invalid');
		}
	});
    
}

function register() {
	var user = {
			nome : $('#input-name-reg').val(),
			cognome : $('#input-surname-reg').val(),
			email : $("#input-email-reg").val(),
			password : $("#input-password-reg").val(),
			confermaPassword : $("#input-conferma-password-reg").val(),
			telefono : $("#input-phone-reg").val(),
			tipo : 0,
			pizzeriaFattorino : "",
			dataRegistrazione : null
	};
	$.ajax({
		url : 'RegistrationServlet',
		type: "POST",
		data : {
			user:JSON.stringify(user)
		},
		success : function(responseText) {
			alert("Registrazione effettuata con successo.");
			location.href = "index.jsp";
		},
		error: function()	{
			alert('Qualcosa non va, controlla i dati inseriti.');
		}
	});
}

function showSettings() {
	$('.navbar-collapse').collapse('hide');
	$('#contenutoPagina').hide().load('settings.jsp').fadeIn('500');
}
function logout() {
	
	$.ajax({
		url : 'AutenticazioneServlet',
		type: "POST",
		data:{
			method: 'logout'
		},
		success : function() {
			
			location.reload();
		}
	});
}
$("#btnControllaOrdine").on('click', function(event) {
	$.ajax({
		url : 'TrackerServlet',
		type: "POST",
		dataType: 'json',
		data : {
			noord : $('#noord').val(),
		},
		success : function(result) {
			$("#noord").removeClass("is-invalid");
			var state;
			var txt = "<div class='col-xl-12'>";
			txt += '<h2>Ordine n.' + result.id + '</h2>';
			txt += "<div class=\"progress\" style=\"height: 4vh; width: 60%; margin:auto; margin-bottom: 4vh;\"> <div class=\"progress-bar progress-bar-striped bg-warning\" role=\"progressbar\" style=\"width: " + result.state +"%\" aria-valuenow=\"" + result.state + "\" aria-valuemin=\"0\" aria-valuemax=\"100\"></div></div>";	
			if (result.state == 0) state = "Stato inviato";
			else if (result.state == 25) state = "Stato ricevuto";
			else if (result.state == 50) state = "In preparazione";
			else if (result.state == 75) state = "In consegna";
			else if (result.state == 100) state = "Stato consegnato";
			txt += '<h3>Il tuo ordine &egrave; <b>' + state + '</b></h3>';
			txt += '</div>';
			$(".div-tracker").hide().html(txt).fadeIn('500');		 
		},
		error : function() {
			$("#noord").addClass("is-invalid");
		}
	});
})

function showSpecifiedSetting(what) {
	if (what == "accountSettings") {
		$(".card-header").hide().html('<h2>Impostazioni account</h2>').fadeIn('500');
		$(".card-body").load('components/divAccountSettings.jsp') 
		
	} else if (what=="address"){
		$(".card-header").hide().html('<h2>Indirizzi di consegna</h2>').fadeIn('500');
		$(".card-body").load('components/divAddresses.jsp');
			
		
	} else if(what == "paymentMethod") {
		$(".card-header").hide().html('<h2>Metodi di pagamento</h2>').fadeIn('500');
		$(".card-body").load('components/divPaymentMethod.jsp')
		
	} else if (what == "myOrders") {
		$(".card-header").hide().html('<h2>Ordini effettuati</h2>').fadeIn('500');
		$(".card-body").load('components/divReportOrder.jsp').fadeIn('500');
	}
}

function updateData() {
	
	$.ajax({
		url : 'ImpostazioniServlet',
		type: "POST",
		data : {
			
			method : 'aggiornaDati',
			nome : $("#nome").val(),
			cognome : $("#cognome").val(),
			email : $("#email").val(),
			telefono: $("#telefono").val()
		},
		success : function(result) {
			showSpecifiedSetting("accountSettings");
		},
		error : function(result) {
			alert('Impossibile modificare.');
		}
	});
}

function changePassword(modulo) {
	if($("#vecchiaPassword").val() ==""){
		alert("Errore password");
		
		return false
	}
	else if($("#newPassword").val() != $("#confirmNewPassword").val())	
	{
		alert("le password non coincidono")
		
		return false
	}
	else if($("#newPassword").val() =="" ){
		alert("Errore password");
		
		return false
	}
	else if($("#confirmNewPassword").val() =="" ){
		alert("Errore password");
		
		return false
	}else{
	return $.ajax({
		url : 'ImpostazioniServlet',
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

function addAddress() {
	var indirizzo = {
			
			citta : $("#input-citta").val(),
			via : $("#input-via").val(),
			civico : $("#input-civico").val(),
			cap : $("#input-CAP").val()
			
	};
	$.ajax({
		url : 'ImpostazioniServlet',
		type: "POST",
		data : {
			
			method : 'aggiungiIndirizzo',
			indirizzo:JSON.stringify(indirizzo)
		},
		success : function(result) {
			$('#modalAddAddress').modal('hide', showSpecifiedSetting("address"));
		},
		error : function(result) {
			alert('Impossibile modificare.');
		}
	});
}

function addPaymentMethod() {
	var carta ={
			numeroCarta : $("#input-numero-carta").val(),
			scadenza : $("#input-scadenza").val(),
			intestatario : $("#input-intestatario").val(),
			cvc : $("#input-cvc").val()
	};
	$.ajax({
		url : 'ImpostazioniServlet',
		type: "POST",
		data : {
			
			method : 'aggiungiCarta',
			carta:JSON.stringify(carta)
		},
		success : function(result) {
			$('#modalAddPaymentMethod').modal('hide', showSpecifiedSetting("paymentMethod"));
		},
		error : function(result) {
			alert('Impossibile modificare.');
		}
	});
}

function deletePaymentMethod(number) {
	if (confirm("Sicuro di voler cancellare la carta?")) {
		$.ajax({
			url : 'ImpostazioniServlet',
			type: "POST",
			data : {
				
				method : 'rimuoviCarta',
				numero : number
			},
			success : function(result) {
				showSpecifiedSetting("paymentMethod");
			},
			error : function(result) {
				alert('Impossibile cancellare.');
			}
		});
	}
}
function deleteAddress(id) {
	if (confirm("Sicuro di voler cancellare l'indirizzo?")) {
		$.ajax({
			url : 'ImpostazioniServlet',
			type: "POST",
			data : {
				
				method : 'rimuoviIndirizzo',
				numero : id
			},
			success : function(result) {
				showSpecifiedSetting("address");
			},
			error : function(result) {
				alert('Impossibile cancellare.');
			}
		});
	}
}

function retriveByCity() {
	var citySel = $("#city-selected").val();
	
	$.ajax({
		url : 'InformazioniServlet',
		type: "POST",
		data : {
			citta : citySel,
			method : 'getPizzerieByCitta',
		},
		success : function(result) {
			
			toPrint="<h1>Pizzerie disponibili</h1>";
			toPrint+="<ul class=\"list-group list-group-flush w-100 ul-settings\" style=\"border-top: 2px solid #F2C337;\">";
			for (x in result) {
  				toPrint += "<li onclick=\"showProductOfRestaurant('"+ result[x].partitaIva + "', '"+ result[x].nome+"');\" id=\"accountSettings\" class=\"list-group-item\" style=\"background-color: #333333; border-bottom: 2px solid #F2C337;\">" + result[x].nome + "</li>";
			}
			toPrint += "</ul>";
			$("#lista-pizzerie").hide().html(toPrint).fadeIn('500');
		}
	});
}

function showProductOfRestaurant(partitaIva, nome) {
	$(".div-order").hide().load('components/divCategoria.jsp', function(){
		$("#nomePizzeria").html(nome);
		$.ajax({
			url : 'CatalogoServlet',
			type: "POST",
			data : {
				partita : partitaIva,
				method : 'getCategorieRistorante',
			},
			success : function(result) {
				result.forEach(function(element) {
					if (element == "Pizze") {
						$("#cat-pizze").css('display',  'block');
					} else if (element == "Dolci") {
						$("#cat-dolci").css('display',  'block');
					} else if (element == "Bibite") {
						$("#cat-bibite").css('display',  'block');
					}
				});
			}
			
		});
	}).fadeIn('500');
}

function showProductOfCategory(what) {
	
	var nome = $("#nomePizzeria").html();
	var namePizz = nome + " - " + what;
	
	$.ajax({
		url : 'CatalogoServlet',
		type: "POST",
		data : {
			method : 'getProdottiCategoria',
			categoria : what
		},
		success : function(result) {
			
			var iva = result[0].idPizzeria;
			var toPrint ="<div onclick=\"showProductOfRestaurant('"+iva+"','"+nome+"');\" class=\"col\"><i class='material-icons'>arrow_back</i></div><div class=\"col-10\"><h3 id=\"nomePizzeria\"></h3></div><div class=\"col-xl-12\">";
			for (x in result) {
				y = parseInt(x) + 1;
				toPrint+= "<div onclick=\"addProduct('"+result[x].nome+"', '');\" class=\"col-md-3\" style=\"padding-top: 2vh;\"><div class=\"card card-interna\"><div class=\"card-body\" style='font-size: 1.2em;'>"+ result[x].nome +"<br><span style='font-size: 1.5em;'>" + result[x].prezzo + "</span> <i class='material-icons'>euro_symbol</i>" +"</div></div></div>";	
			}
			$(".div-order").hide().html(toPrint).fadeIn('500');
			$("#nomePizzeria").hide().html(namePizz).fadeIn('500');
		}
	});
}


function selectProduct(which, where) {
	$.ajax({
		url : 'CartServlet',
		type: "POST",
		data : {
			method : 'selectProduct',
			nomeProdotto : which
		},
		success : function(result) {
			$("#"+where).addClass("product-selected");
			$("#"+where).attr('onClick', "deselectProduct('"+which+"', '"+where+"');");
			if(where=="productRossa") {
				if ($("#productBianca").hasClass("product-selected")) deselectProduct('bianca', 'productBianca');
				$("#productRossa").attr("onClick", "");
				$("#divSecondoStep").css("display", "flex !important");
			}else if (where == "productBianca") {
				if ($("#productRossa").hasClass("product-selected")) deselectProduct('rossa', 'productRossa');
				$("#productBianca").attr("onClick", "");
				$("#divSecondoStep").css("display", "flex !important");
			}
		}
	});
}
function deselectProduct(which, where) {
	$.ajax({
		url : 'CartServlet',
		type: "POST",
		data : {
			method : 'deselectProduct',
			nomeProdotto : which
		},
		success : function(result) {
			$("#"+where).removeClass("product-selected");
			$("#"+where).attr('onClick', "selectProduct('"+which+"', '"+where+"');");
		}
	});
}
function addProduct(which, from) {
	
	$.ajax({
		url : 'CarrelloServlet',
		type: "POST",
		data : {
			method : 'addProduct',
			nomeProdotto : which
		},
		success : function(result) {
			var numProd = result.numProd;
			$("#numProdInCarrello").hide().html(numProd).fadeIn('500');
			if (from=="carrello") showCart();
		}
	});
}

function decreaseProduct(which) {
	$.ajax({
		url : 'CartServlet',
		type: "POST",
		data : {
			method : 'decreaseProduct',
			nomeProdotto : which
		},
		success : function(result) {
			var numProd = result.numProd;
			$("#numProdInCarrello").hide().html(numProd).fadeIn('500');
			showCart();
		},
		error: function(result){
			
		}
	});
}

function deleteProduct(which) {
	$.ajax({
		url : 'CartServlet',
		type: "POST",
		data : {
			method : 'deleteProduct',
			nomeProdotto : which
		},
		success : function(result) {
			var numProd = result.numProd;
			$("#numProdInCarrello").hide().html(numProd).fadeIn('500');
			showCart();
		}
	});
}

function addCreatedProduct() {
	$.ajax({
		url : 'CartServlet',
		type: "POST",
		data : {
			method : 'addCreatedProduct'
		},
		success : function(result) {
			var numProd = result.numProd;
			$("#numProdInCarrello").hide().html(numProd).fadeIn('500');
			showProductComponibili();
		}
	});
}
function showCart() {
	$('.navbar-collapse').collapse('hide');
	$('#contenutoPagina').hide().load('components/divCarrello.jsp', function() {
		$.ajax({
			url : 'CartServlet',
			type: "POST",
			data : {
				method : 'showCartProduct'
			},
			success : function(result) {
				$("#spesa").html("Spesa totale: " + result.total + "  &euro;");
				var toPrint = "";
				if (result.numProd == "0") $("#contenutoPagina").html('<div class=\"row col-12\" style=\"padding-top: 15px; background-color: #333333; color: #F2C337;\"><p class=\"mx-auto\">Non ci sono prodotti in carrello</p></div>');
				for (x in result.array) {
					var nome = result.array[x].productName;
					var price = result.array[x].price;
					var qnt = result.array[x].quantity;
					toPrint += 
					"<div class=\"row product-row "+nome+"\">"+
					"<div class=\"col-4 col-md-3 col-lg-3\" id=\"nome\"> <p>"+nome+"</p></div>"+
					"<div class=\"col-1 col-md-2 col-lg-2\" id=\"quantita\">"+qnt+"</div>"+
					"<div class=\"col-2 col-md-2 col-lg-2\" id=\"prezzo\">"+price+"</div>"+
					"<div class=\"col-2 col-md-3 col-lg-3\">"+
					"<i class=\"material-icons material-cart\" onclick=\"addProduct('"+nome+"', 'carrello');\" id=\"add-cart\">add</i>"+
					"<i class=\"material-icons material-cart\" id=\"remove-cart\" onclick=\"decreaseProduct('"+nome+"');\" >remove</i>"+
					"<i class=\"material-icons material-cart\" id=\"delete-cart\" onclick=\"deleteProduct('"+nome+"');\"> delete</i>"+
					"</div>"+
					"<div class=\"col-1 col-md-2 col-lg-2\" id=\"totale\">"+qnt*price+" </div>"+
				"</div>";
				}
				$(".row-to-print").html(toPrint);
				
			}
		});
	}).fadeIn('700');
};

function checkOut() {
	$("#contenutoPagina").hide().load('components/divCheckout.jsp').fadeIn('500');
}

function setPaymentMethod(which) {
	$.ajax({
		url : 'OrderServlet',
		type: "POST",
		data : {
			method : 'setPaymentMethod',
			card : which
		},
		success : function(result) {
			$(".carta-credito").removeClass("product-selected");
			$("#card-card-"+which).addClass("product-selected");
		}
	});
	
}

function setAddress(which) {
	$.ajax({
		url : 'OrderServlet',
		type: "POST",
		data : {
			method : 'setAddress',
			address : which
		},
		success : function(result) {
			$(".indirizzo").removeClass("product-selected");
			$("#card-address-"+which).addClass("product-selected");
		}
	});
}

function confermaOrdine() {
	$.ajax({
		url : 'OrderServlet',
		type: "POST",
		data : {
			method : 'confirmOrder'
		},
		success : function(result) {
			$("#contenutoPagina").hide().html(
					"<div class=\"row tracker\" style=\"background-color: #333333; text-align: center; color: green;\">"+
						"<div class=\"col-xl-12\">"+
							"<h1>Ordine n." + result + " confermato</h1>"+
					    	"<i class=\"material-icons\" style=\"font-size:10em\">check_circle_outline</i>"+
					     "</div>"+				
					"</div>").fadeIn('500');	
			$("#numProdInCarrello").hide().html("").fadeIn('500');
		}, 
		error : function(result) {
			$("#cont-p-invalid").css("opacity", "1");
		}
	});
}

function showReview(where, restaurant) {
	$("#modalOrder").modal('show');
	$.ajax({
		url : 'OrderServlet',
		type: "POST",
		data : {
			method : 'getDetailReview',
			ordine : where
		},
		success : function(result) {
			$("#modalOrderTitle").html("Recensione - ordine n."+result.ordine)
			$("#modalOrder .modal-body").html("Hai gia' lasciato una recensione: <br>\""+result.recensione+"\"");
			$("#modalOrder .modal-footer").html("");
		}, 
		error : function(result) {
			$("#modalOrderTitle").html("Recensione - ordine n."+where);
			var toPrint="<span style=\"color: green;\">Non hai ancora lasciato una recensione.</span><br>"+
						"<div class=\"form-group\">"+
							"<label for=\"numberStar\">Stelle</label>"+
							"<select class=\"form-control\" id=\"numberStar\">"+
								"<option value=\"1\">1</option>"+
								"<option value=\"2\">2</option>"+
								"<option value=\"3\">3</option>"+
								"<option value=\"4\">4</option>"+
								"<option value=\"5\">5</option>"+
							"</select>"+
						"</div>"+
						"<div class=\"form-group\">"+
							"<label for=\"commento\">Commento</label>"+
							"<textarea class=\"form-control\" id=\"commento\" rows=\"5\" cols=\"20\"></textarea>"+
						"</div>";
			$("#modalOrder .modal-body").html(toPrint);
			$("#modalOrder .modal-footer").html("<button onclick=\"sendReview('"+where+"', '"+restaurant+"');\" class=\"btn btn-primary\">Invia</button>");
		}
	});
}
function sendReview(ordine, risto) {
	$.ajax({
		url : 'OrderServlet',
		type: "POST",
		data : {
			method : 'sendReview',
			ordine : ordine,
			stelle : $("#numberStar").val(),
			commento : $("#commento").val(),
			ristorante : risto
		},
		success : function(result) {
			$("#modalOrder").modal('hide');
			$(".card-header").hide().html('<h2>Ordini effettuati</h2>').fadeIn('500');
			$(".card-body").hide().load('components/divReportOrder.jsp').fadeIn('500');
		}, 
		error : function(result) {
			alert('error');
		}
	});
}
function registraRichiesta() {
	var richiesta = {
			id:null,
			nome : $('#input-name-reg').val(),
			cognome : $('#input-surname-reg').val(),
			nomePizzeria: $('#input-pizzeria-reg').val(),
			email : $("#input-email-reg").val(),
			password : $("#input-password-reg").val(),
			confermaPassword : $("#input-conferma-password-reg").val(),
			telefono : $("#input-phone-reg").val(),
			stato : "In Valutazione",
			date : null,
			commento : $("#input-commento-reg").val(),
			partitaIva: $("#input-partita-reg").val(),
	};
	$.ajax({
		url : 'AffiliazioneServlet',
		type: "POST",
		data : {
			method:'registra',
			richiesta:JSON.stringify(richiesta)
		},
		success : function() {
			alert("Registrazione effettuata con successo.");
			location.href = "index.jsp";
		},
		error: function()	{
			alert('Qualcosa non va, controlla i dati inseriti.');
		}
	});
}
