
if (document.querySelector('.stripe-button-el')) {
  var stripButton = document.querySelector('.stripe-button-el')
  stripButton.classList.remove('stripe-button-el')
  stripButton.classList.add('btn')
  stripButton.classList.add('btn-default')
  stripButton.classList.add('form-button')
}

if (document.querySelector("span[style]")) {
  document.querySelector("span[style]").style.minHeight = null
}
