document.addEventListener("turbolinks:load", function () {
  var activeTab = $('.app-main-body > div:first-child').data('tab-name');
  $('.app-navbar-collapse li[data-tab-name='+activeTab+']').addClass('app-active-tab');
});