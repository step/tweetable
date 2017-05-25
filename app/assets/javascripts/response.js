var calculateRemainingChars = function (charLimit) {
    var value = $('#text').val() || '';
    var totalChars = charLimit - value.length;
    $('#totalChars').html(totalChars);
};

document.addEventListener("turbolinks:load", function () {
    var responseCharLimit = $('#text').attr('maxlength');
    var countCharacters = function () {
        calculateRemainingChars(responseCharLimit);
    };
    $('#totalChars').html(responseCharLimit);
    $('#text').on('input', countCharacters);
});
