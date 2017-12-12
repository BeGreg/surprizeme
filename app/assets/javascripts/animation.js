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

fil = document.getElementById("fil")
pince = document.getElementById("pince")

document.addEventListener("DOMContentLoaded", function() {
  fetch("/scrap-achat", {
    method: "POST",
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    },
    body: JSON.stringify({ message:"hello" }),
    credentials: 'same-origin'
  }).then(() => {
      console.log("recu!")
      fil.addEventListener("animationiteration", function() {
        fil.classList.remove('fil');
        fil.classList.add('fil2');
        pince.classList.add('pince-cadeau');
        fil.addEventListener("animationend", function() {
        window.location.href = "/"
      });
    });
  });
});

