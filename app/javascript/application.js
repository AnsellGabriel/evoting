// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"
import * as bootstrap from "bootstrap"
import "chartkick"
import "Chart.bundle"

Turbo.session.drive = true
window.bootstrap = bootstrap

document.addEventListener("turbo:load", function () {

  // Initialize Bootstrap tooltips
  var tooltipTriggerList = [].slice.call(
    document.querySelectorAll('[data-bs-toggle="tooltip"]')
  );
  
  var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl);
  });

  // Initialize Bootstrap toasts
  var toastEle = document.getElementById('notificationToast')

  if (toastEle) {
    var toast = new bootstrap.Toast(toastEle)
    toast.show()
  }
});