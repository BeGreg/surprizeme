function homepageAnimation() {
  var product = document.querySelector(".product-title");
  var product_form = document.querySelector(".product-form");
  var moment = document.querySelector(".moment-title");
  var moment_form = document.querySelector(".moment-form");

  var product_title = document.querySelector(".product-title");
  var moment_title = document.querySelector(".moment-title");

  var headline = document.querySelector(".headline");
  var headline_text = document.querySelector(".headline-text");


  // What happens to title when selected



  // What happens when you click on "Product"
  product.addEventListener("click", function() {

    product_form.classList.toggle("event-hide");
    product_form.classList.toggle("cat-show");
    moment_form.classList.remove("cat-show");
    moment_form.classList.add("event-hide");
    HeadlineMove();
    TitleMove(product_form, moment_form, product_title, moment_title)

    if (product_form.classList.contains("cat-show")) {
      product.classList.add("cat-selected");
      moment.classList.remove("cat-selected");

    } else {
      product.classList.remove("cat-selected");

    }


  });



  // What happens when you click on "Moment"
  moment.addEventListener("click", function() {

    moment_form.classList.toggle("event-hide");
    moment_form.classList.toggle("cat-show");
    product_form.classList.remove("cat-show");
    product_form.classList.add("event-hide");
    HeadlineMove();
    TitleMove(moment_form, product_form, moment_title, product_title)
    if (moment_form.classList.contains("cat-show")) {
      moment.classList.add("cat-selected");
      product.classList.remove("cat-selected");
    } else {
      moment.classList.remove("cat-selected");

    }

  });

  // what happense to Headline when interacting with page
  function HeadlineMove() {
    if (product_form.classList.contains("cat-show") || moment_form.classList.contains("cat-show")) {
      headline.style.visibility = "hidden"
      headline_text.style.visibility = "hidden"


    }else{
      headline.style.visibility = "visible"
      headline_text.style.visibility = "visible"
    }
  };

  // what happense to Title when interacting with page
  function TitleMove(x, y, a, b) {
    if (x.classList.contains("cat-show")) {
      a.style.top ="5vh"
      a.style.transition = "all 500ms"
      b.style.top ="25vh"
      b.style.transition = "all 500ms"

    }else{
      a.style.top ="25vh"
      a.style.transition = "all 500ms"
      }
    }


  // what happens when you click on "Comment Ca marche ? "
  var category_select = document.querySelectorAll(".category-select");
  var howLink = document.getElementById("how-link");
  var howItWorks = document.getElementById("how-it-works");
  howLink.addEventListener("click", function() {
    howItWorks.classList.toggle("hide-how");
    howItWorks.classList.toggle("show-how");
    HowItWorks()
  });

  function HowItWorks() {
    if (howItWorks.classList.contains("hide-how")) {
      category_select.forEach( function(x) {
        x.style.height="100vh";
      });

    }else{
      category_select.forEach(function(x) {
        x.style.height="200vh";
      });

    };
  };
}
