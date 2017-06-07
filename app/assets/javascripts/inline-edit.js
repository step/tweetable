document.addEventListener("turbolinks:load", function () {
    $(document).ready(function () {
        $.fn.editable.defaults.mode = 'inline';
        $('.editable').editable({
            ajaxOptions: {
                type: 'PUT'
            }
        })
    });
});
