
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
  }).then((response) => response.json())
    .then((answer) => {
      var url = answer.url
      fil.addEventListener("animationiteration", function() {
        fil.classList.remove('fil');
        fil.classList.add('fil2');
        pince.classList.add('pince-cadeau');
        fil.addEventListener("animationend", function() {
        window.location.pathname = url
      });
    });
  });
  }
});


