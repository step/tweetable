document.addEventListener("turbolinks:load", function () {
    $('#add-group').on('click',function (event) {
        $.get("groups/new", function (data) {
            $('#app-add-group-modal-body').html(data);
            $('#myGroupModal').show()
        });
    });
});
