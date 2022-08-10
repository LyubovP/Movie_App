// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"
import "./jquery"
import "./jquery.raty"
import "turbolinks"

$('.star-rating').raty({
    path: '/assets/',
    readOnly: true,
    score: function() {
          return $(this).attr('data-score');
  }
});

$('#add-rating').raty({
    path: '/assets/',
    scoreName: 'review[rating]'
  });