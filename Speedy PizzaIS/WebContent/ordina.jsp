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
		<div id="contenutoPagina">
			<div class="row div-order">
				<div class="col-xl-12">
					<h2>Dove dobbiamo consegnare?</h2>
				</div>
				<div class="col-md-12">
					<input id="autocomplete" onfocus=geolocate() list="list-citta" type="text" placeholder="Indirizzo" class="form-control input-bordered" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" style="width: 90%;">
					<button onclick="retriveByCity();" type="button" class="btn btn-outline-success btn-prosegui" >Prosegui</button>
					
				</div>
				<div class="col-md-12" id="lista-pizzerie">
				
				</div>
				
			</div>
			<input type="hidden" id="nomePizzeria" value=""/>
			
		</div>
	<%@ include file = "footer.jsp" %>
	</div>
	<script >
		var placeSearch,autocomplete;
		function geolocate() {
			  if (navigator.geolocation) {
			    navigator.geolocation.getCurrentPosition(function(position) {
			      var geolocation = {
			        lat: position.coords.latitude,
			        lng: position.coords.longitude
			      };
			      var circle = new google.maps.Circle(
			          {center: geolocation, radius: position.coords.accuracy});
			      autocomplete.setBounds(circle.getBounds());
			    });
			  }
			}
		function fillInAddress() {
			  // Get the place details from the autocomplete object.
			  var place = autocomplete.getPlace();

			  for (var component in componentForm) {
			    document.getElementById(component).value = '';
			    document.getElementById(component).disabled = false;
			  }

			  // Get each component of the address from the place details,
			  // and then fill-in the corresponding field on the form.
			  for (var i = 0; i < place.address_components.length; i++) {
			    var addressType = place.address_components[i].types[0];
			    if (componentForm[addressType]) {
			      var val = place.address_components[i][componentForm[addressType]];
			      document.getElementById(addressType).value = val;
			    }
			  }
			}
		function initAutocomplete() {
			  // Create the autocomplete object, restricting the search predictions to
			  // geographical location types.
			  autocomplete = new google.maps.places.Autocomplete(
			      document.getElementById('autocomplete'), {types: ['geocode']});

			  // Avoid paying for data that you don't need by restricting the set of
			  // place fields that are returned to just the address components.
			  autocomplete.setFields(['address_component']);

			  // When the user selects an address from the drop-down, populate the
			  // address fields in the form.
			  autocomplete.addListener('place_changed', fillInAddress);
			}
	</script>
	<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<script src="script.js"></script>
	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD9xlq0bGvWJWELWto7CkZhASL_skg-uzM&libraries=places&callback=initAutocomplete"
        async defer></script>	
</body>
</html>