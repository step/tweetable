document.addEventListener("turbolinks:load", function() {
  $('#add-tag').on('click', function(_) {
    $.get("tags/new", function(data) {
      $('#app-add-tag-modal-body').html(data);
      var addTagModal = $('#app-add-tag-modal');
      addTagModal.show();
      addTagModal.find('.app-add-tag-form-color').colorpicker({
        color:'#5bc0de',
        format:'hex',
        customClass: 'app-tag-color-picker'
      });
    });
  });

  $('.app-tag-color-container').each(function(_, element) {
    $(element).colorpicker().on('changeColor', function(e) {

    }).on('hidePicker',function(e){
      var old = $(this).data('old-color');
      var newColor = $(e.target).data('colorpicker').color.toHex();
      if(old.match(newColor))
        return;
      $.ajax({
        method: 'put',
        dataType: 'json',
        url: $(this).data('url'),
        data: {
          tag: {
            color: newColor
          }
        }
      }).done(function(data) {
        var mainBody = $('.app-main-body');
        var ele = $('<div></div>',{text: data.name + ' color has been updated.', class: 'alert alert-success'});
        if(mainBody.find('.alert').length > 0){
          mainBody.find('.alert').remove();
          mainBody.prepend(ele);
        }else{
          mainBody.prepend(ele);
        }
      });
    })
  });

});
