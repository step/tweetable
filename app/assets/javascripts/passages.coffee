click_active_tab = ->
  $("#prodTabs .active a").click()

assign_roll_out = ->
  $('.roll_out_buttons i').on 'click', (e) ->
    e.preventDefault()
    url = $(this).attr('data-url')
    return $.getJSON(url, (result) ->
      click_active_tab()
      return
    )

assign_tabs_click = ->
  $('#tabs').on 'click', '.tablink,#prodTabs a', (e) ->
    e.preventDefault()
    url = $(this).attr('data-url')
    if typeof url != 'undefined'
      pane = $(this)
      href = @hash
      $(href).load url, (result) ->
        assign_roll_out()
        pane.tab 'show'
        return
    else
      $(this).tab 'show'
    return

ready = ->
  assign_tabs_click()
  click_active_tab()
  return

$(ready)


