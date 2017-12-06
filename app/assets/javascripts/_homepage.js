const product = document.querySelector(".product-title");
const product_form = document.querySelector(".product-form");
const moment = document.querySelector(".moment-title");
const moment_form = document.querySelector(".moment-form");

const product_title = document.querySelector(".product-title");
const moment_title = document.querySelector(".moment-title");

const headline = document.querySelector(".headline");
const headline_text = document.querySelector(".headline-text");


// What happens when you click on "Product"
product.addEventListener("click", (event) => {

  product_form.classList.toggle("event-hide");
  product_form.classList.toggle("cat-show");
  moment_form.classList.remove("cat-show");
  moment_form.classList.add("event-hide");
  HeadlineMove();
  TitleMove(product_form, moment_form, product_title, moment_title)

});


// What happens when you click on "Moment"
moment.addEventListener("click", (event) => {

  moment_form.classList.toggle("event-hide");
  moment_form.classList.toggle("cat-show");
  product_form.classList.remove("cat-show");
  product_form.classList.add("event-hide");
  HeadlineMove();
  TitleMove(moment_form, product_form, moment_title, product_title)

});

// what happense to Headline when interacting with page
function HeadlineMove() {
  if (product_form.classList.contains("cat-show") || moment_form.classList.contains("cat-show")) {
    headline.classList.add("move-up");
    headline.classList.remove("move-down");
    headline_text.classList.add("move-up");
    headline_text.classList.remove("move-down");

  }else{
    headline.classList.add("move-down");
    headline.classList.remove("move-up");
    headline_text.classList.add("move-down");
    headline_text.classList.remove("move-up");
    product_title.style.top ="25vh"
    product_title.style.transition = "all 1500ms"
  }
};

// what happense to Title when interacting with page
function TitleMove(x, y, a, b) {
  if (x.classList.contains("cat-show")) {
    a.style.top ="15vh"
    a.style.transition = "all 1500ms"
    b.style.top ="25vh"
    b.style.transition = "all 1500ms"

  }else{
    a.style.top ="25vh"
    a.style.transition = "all 1500ms"
    }
  }


// what happens when you click on "Comment Ca marche ? "
const howLink = document.getElementById("how-link");
const howItWorks = document.getElementById("how-it-works");
howLink.addEventListener("click", (event) => {
  howItWorks.classList.toggle("hide-how");
  howItWorks.classList.toggle("show-how");
  HowItWorks()
});

function HowItWorks() {
  if (howItWorks.classList.contains("hide-how")) {
    product.style.height="100vh";
    moment.style.height="100vh";
  }else{
    product.style.height="200vh";
    moment.style.height="200vh";
  }
};

