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
    var date = new Date();
    var time = $("#remaining_time").html();
    date.setSeconds(time);
    $("#remaining_time")
        .countdown(date.toLocaleDateString(), function (event) {
            $(this).text(
                event.strftime('%H:%M:%S')
            );
        });
});

