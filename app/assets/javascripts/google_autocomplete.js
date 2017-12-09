function onPlaceChanged() {
  var place = this.getPlace();
  var delAddress = document.getElementById('surprise_del_address');
  delAddress.blur();
  delAddress.value = place.formatted_address;
}

document.addEventListener("DOMContentLoaded", function() {
  var delAddress = document.getElementById('surprise_del_address');

  if (delAddress) {
    var autocomplete = new google.maps.places.Autocomplete(delAddress, { types: ['geocode'], componentRestrictions: {country: 'fr'} });
    google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChanged);
  }
});

// var input = document.getElementById('searchTextField');
// var options = {
// restriction totale à la France
//   types: ['(cities)'],
//   componentRestrictions: {country: 'fr'}
// };
