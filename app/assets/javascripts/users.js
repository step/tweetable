function submitForm(action) {
    $(action).click(function () {
        $(this).parents('form').submit();
    });
}
document.addEventListener("turbolinks:load", function () {
    submitForm('.submittable_active');
    submitForm('.submittable_admin');
});