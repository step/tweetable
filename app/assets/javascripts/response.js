counter = function () {
    var value = $('#text').val();

    var totalChars = 140 - value.length;

    $('#totalChars').html(totalChars);
};

$(document).ready(function () {
    $('#text').keydown(counter);
    $('#text').keypress(counter);
});
