function initCheckboxBillingAddress(){
  const checkbox = document.getElementById('bill_address')
  const billing_address = document.querySelector(".billing_address");
  const delivery_address = document.querySelector(".delivery_address");

  checkbox.addEventListener("click", function(){
    billing_address.classList.toggle("bill-hide");
    billing_address.classList.toggle("bill-show");

  if (billing_address.classList.contains("bill-show")) {
    delivery_address.style.padding = "0 20px 0 0";
  } else {
    delivery_address.style.padding = "0";
  };
});

  };








