// function() {
//   // Do something (callback)
//   fetch("/add_item", {
//     method: "POST",
//     headers: {
//       'Content-Type': 'application/json',
//       'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
//     },
//     body: JSON.stringify({ id: event.currentTarget.id, quantity:1 }),
//     credentials: 'same-origin'
//   })

// function onPlaceChanged(address_field) {
//   var place = this.getPlace();
//   var adress = document.getElementById(address_field);
//   address.blur();
//   address.value = place.formatted_address;
// }


document.addEventListener("DOMContentLoaded", function() {
  var surpriseId = document.getElementById("animation").getAttribute('data-surprise-id')
  fil = document.getElementById("fil");
  pince = document.getElementById("pince");

  if (fil) {
  console.log('on va fetcher');
  fetch("/scrap-purchase", {
    method: "POST",
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    },
    body: JSON.stringify({ id: surpriseId }),
    credentials: 'same-origin'
  }).then((answer) => {
      var url = answer
      fil.addEventListener("animationiteration", function() {
        fil.classList.remove('fil');
        fil.classList.add('fil2');
        pince.classList.add('pince-cadeau');
        fil.addEventListener("animationend", function() {
        window.location.href = url
      });
    });
  });
  }
});


