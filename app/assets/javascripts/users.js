function submitCheckboxAction() {
    $('.submittable').click(function () {
        $(this).parents('form').submit();
    });
}

document.addEventListener("turbolinks:load", function () {
    submitCheckboxAction();
});