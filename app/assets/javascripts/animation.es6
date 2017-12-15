var translation = document.getElementById("translation")

function setRandomAnimationDistance() {
  var animationDistance = (Math.random()*60 + 20) + '%';
  setProperty(animationDistance);
}

function setProperty(distance) {
  animation.style.setProperty('--animation-distance', distance);
}

if (translation) {
  animation.addEventListener("animationiteration", setRandomAnimationDistance)
}

document.addEventListener("DOMContentLoaded", function() {
  if (document.getElementById("animation")) {
    var surpriseId = document.getElementById("animation").getAttribute('data-surprise-id')
  }
  var fil = document.getElementById("fil");
  var pince = document.getElementById("pince");

  if (fil) {
  console.log('on va fetcher');
  fetch("/scrap-purchase", {
    method: "POST",
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    },
    body: JSON.stringify({ id: surpriseId }),
    credentials: 'same-origin',
    timeout: 60000
  }).then((response) => response.json())
    .then((answer) => {
      var url = answer.url
      fil.addEventListener("animationiteration", function() {
        fil.classList.remove('fil');
        fil.classList.add('fil2') ;
        pince.classList.add('pince-cadeau');
        fil.addEventListener("animationend", function() {
          window.location.pathname = url
        });
      });
    });
  }
});
