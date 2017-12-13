function onPlaceChanged(address_field) {
  var place = this.getPlace();
  var adress = document.getElementById(address_field);
  address.blur();
  address.value = place.formatted_address;
}

document.addEventListener("DOMContentLoaded", function() {
  var billAddress = document.getElementById('surprise_bill_address');
  var delAddress = document.getElementById('surprise_del_address');

  autocompletes.forEach()

  if (delAddress) {
    var autocomplete = new google.maps.places.Autocomplete(delAddress, { types: ['geocode'], componentRestrictions: {country: 'fr'} });
    google.maps.event.addListener(autocomplete, 'place_changed', function() {
      onPlaceChanged('surprise_del_address')
    });
  }

  if (billAddress) {
    var autocomplete = new google.maps.places.Autocomplete(billAddress, { types: ['geocode'], componentRestrictions: {country: 'fr'} });
    google.maps.event.addListener(autocomplete, 'place_changed', function() {
      onPlaceChanged('surprise_bill_address')
    });
  }

});
