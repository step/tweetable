var assign_roll_out, assign_tabs_click, click_active_tab, ready;

click_active_tab = function () {
  return $("#prodTabs .active a").click();
};

assign_roll_out = function () {
  return $('.passage_action_buttons i').on('click', function (e) {
    var url;
    e.preventDefault();
    url = $(this).attr('data-url');
    return $.getJSON(url, function (result) {
      click_active_tab();
    })
  })
};

assign_tabs_click = function () {
  return $('#tabs').on('click', '.tablink,#prodTabs a', function (e) {
    var href, pane, url;
    e.preventDefault();
    url = $(this).attr('data-url');
    if (typeof url !== 'undefined') {
      pane = $(this);
      href = this.hash;
      $(href).load(url, function (result) {
        assign_roll_out();
        pane.tab('show');
      });
    } else {
      $(this).tab('show');
    }
  });
};

ready = function () {
  assign_tabs_click();
  click_active_tab();
};

$(document).on('turbolinks:load', ready);