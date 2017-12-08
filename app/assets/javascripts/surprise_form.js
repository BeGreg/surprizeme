var checkbox = document.getElementById('bill_address')
checkbox.addEventListener("click", function(){
  console.log("click");
  var billing_address = $(".billing_address");
  console.log(billing_address);
  billing_address.toggleClass("hidden")
})



