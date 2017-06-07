
document.addEventListener("turbolinks:load", function () {
    $('#add-tag').on('click',function (event) {
        $.get("tags/new", function (data) {
            $('#app-add-tag-modal-body').html(data);
            $('#myModal').show()
        });
    });
});

