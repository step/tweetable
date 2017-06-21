document.addEventListener("turbolinks:load", function() {
  $('#add-tag').on('click', function(event) {
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
});
