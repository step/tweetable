document.addEventListener("turbolinks:load", function() {
  initializeTagColor();
  onClickOnColorCell();

  $('#add-tag').on('click', function(_) {
    $.get("tags/new", function(data) {
      $('#app-add-tag-modal-body').html(data);
      var addTagModal = $('#app-add-tag-modal');
      initializeNewTagColor();
      initializeNewTagColorCell();
      addTagModal.show();
    });
  });

  $(".app-tag-color-input").on("change", function(event) {
    var self = $(this);
    var tagColor = self.val();
    var url = self.parent().data('url');
    var tagId = self.parent().data('tag-id')
    var data = {
      tag: {
        color: tagColor
      }
    };
    backendRequest(url,'put',data);
    changeAddonColor(tagId, tagColor);
  });

});
var backendRequest = function (url,method,data) {
  requester(url,method,data).done(function(data) {
    var mainBody = $('.app-main-body');
    var ele = $('<div></div>', {
      text: data.message,
      class: 'alert alert-success'
    });
    if (mainBody.find('.alert').length > 0) {
      mainBody.find('.alert').remove();
      mainBody.prepend(ele);
    } else {
      mainBody.prepend(ele);
    }
    remove_flash_messages();
  });
};

var initializeTagColor = function() {
  $(".input-group-addon").each(function(_, addOn) {
    var color = $(addOn).data("tag-color");
    $(addOn).css('background-color', color);
  });
};

var onClickOnColorCell = function () {
  $(".app-tag-color-cell").on('click',function () {
    var tagParent = $(this).parent();
    var tagId = tagParent.data('tag-id');
    var url = tagParent.data('url');
    var tagColor = $(this).data('color');
    var data = {
      tag: {
        color: tagColor
      }
    };
    backendRequest(url,'put',data);
    changeAddonColor(tagId, tagColor);

  })
};
var initializeNewTagColor = function () {
  $(".app-new-tag-color-input").on("input",function (event) {
    var el = $(this);
    var color = $(el).val();
    $(".on-new").css('background-color',color);
  });
};
var initializeNewTagColorCell = function () {
  $(".new-tag-color-cell").on('click',function () {
    var tagColor = $(this).data('color');
      $(".on-new").css('background-color',tagColor);
      $(".app-new-tag-color-input").val(tagColor);
  })

}
var changeAddonColor = function(tagId, color) {
  var targetTag = $('#tag-addon-' + tagId);
  targetTag.css('background-color', color);
  targetTag.parent().removeClass("open");
};
