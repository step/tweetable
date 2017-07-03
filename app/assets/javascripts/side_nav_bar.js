document.addEventListener("turbolinks:load", function () {
  var activeTab = $('.app-main-body > div:first-child').data('tab-name');
  $('.app-navbar-collapse li[data-tab-name='+activeTab+']').addClass('app-active-tab');

});
function fixSideNavBarHeight(e) {
  var sideNavBAr = $($(e).data('target'));

  var attr = sideNavBAr.attr('aria-expanded') || 'false';
  if(attr.match(/^true$/i)) {
    sideNavBAr.hide();
    $('.app-sidebar-links-container').css('height', 'auto');
  }
  else {
    sideNavBAr.show();
    $('.app-sidebar-links-container').css('height', '100%');
  }

}
