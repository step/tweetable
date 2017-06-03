function submitCheckboxAction() {
    $('.submittable').click(function () {
        $(this).parents('form').submit();
    });
}

$(document).ready(function () {
    submitCheckboxAction();
});