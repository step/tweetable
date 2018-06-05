function submitForm(action) {
    $(action).click(function () {
        $(this).parents('form').submit();
    });
}

function submitRole(action) {
    $(action).change(function () {
        $(this).parents('form').submit();
    });
}

document.addEventListener("turbolinks:load", function () {
    submitForm('.submittable_active');
    submitRole('.submittable_role');
});