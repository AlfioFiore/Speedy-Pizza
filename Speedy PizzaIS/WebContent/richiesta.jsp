<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
	<link rel="stylesheet" href="style/style.css">
	
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

</head>
<body>
<%@ include file = "modals.html" %>
	<div class="container-fluid">
		
	
		<%@ include file = "header.jsp" %>
		<div class="col-xl-12 div-registrazione" style="padding-top: 2vh;">
			<form onsubmit="registraRichiesta(); return false" >
				<h1>Richiesta Affiliazione</h1>
				<div class="form-group" >
					<label for="input-nome" style="color: green;">Nome titolare</label>
					<input type="text" class="form-control input-bordered" id="input-name-reg" style="width: 90%" pattern="[a-zA-z]{2,19}" required>
				</div> 	
				
				<div class="form-group">
					<label for="input-cognome" style="color: green;">Cognome titolare</label>
					<input type="text" class="form-control input-bordered" id="input-surname-reg"  style="width: 90%" pattern="[a-zA-z ]{2,29}" required>
				</div>
				<div class="form-group">
					<label for="input-cognome" style="color: green;">Nome pizzeria</label>
					<input type="text" class="form-control input-bordered" id="input-pizzeria-reg"  style="width: 90%" pattern="[a-zA-Z0-9\-\s]{3,19}" required>
				</div>
				<div class="form-group">
					<label for="input-email" style="color: green;">E-mail</label>
					<input type="email" class="form-control input-bordered" id="input-email-reg" style="width: 90%" pattern="^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$" required>
				</div>
				<div class="form-group">
					<label for="input-password" style="color: green;">Password</label>
					<input type="password" class="form-control input-bordered" id="input-password-reg" style="width: 90%" pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{5,}" placeholder="Minimo 6 caratteri - Almeno una lettera e un numero" required>
				</div>
				<div class="form-group">
					<label for="input-conferma-password" style="color: green;">Conferma password</label>
					<input type="password" class="form-control input-bordered" id="input-conferma-password-reg" pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{5,}" style="width: 90%" required>
				</div>
				
				<div class="form-group">
					<label for="phone" style="color: green;">Telefono</label>
					<input type="tel" class="form-control input-bordered" id="input-phone-reg" style="width: 90%" pattern="[0-9]{9,14}" required>
				</div>
				<div class="form-group">
					<label for="phone" style="color: green;">Commento</label>
					<input type="text" class="form-control input-bordered" id="input-commento-reg" style="width: 90%" pattern="[a-zA-Z0-9 ,]{0,499}"required>
				</div>
				<div class="form-group">
					<label for="input-partita" style="color: green;">Partita iva</label>
					<input type="text" class="form-control input-bordered" id="input-partita-reg" style="width: 90%" pattern="[0-9]{11}" required>
				</div>
				<input id="btnRegistraRichiesta" type="submit" class="btn btn-outline-success" value="Invia richiesta" style="width: 90%; font-size: 1.2em; margin-top: 4vh; border: 2px solid green;">
			</form>
		</div>
		<%@ include file = "footer.jsp" %>
	</div>
			
	

	<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<script src="script.js"></script>

</body></html>
	