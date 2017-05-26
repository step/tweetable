var updateRemainingCharacters = function (event) {
    var charLimit = event.target.maxLength;
    var presentCount = event.target.value.length;
    var totalChars = charLimit - presentCount;
    $('#totalChars').html(totalChars);
};

var showRemainingTime = function () {
    var date = new Date();
    var remainingTimeElement = $("#remaining_time");
    var time = remainingTimeElement.html();
    date.setSeconds(time);
    remainingTimeElement
        .countdown(time, function (event) {
            $(this).text(
                event.strftime('%H:%M:%S')
            );
        });
};

var showRemainingCharacters = function () {
    $('#text').on('input', updateRemainingCharacters);
};

document.addEventListener("turbolinks:load", function () {
    showRemainingCharacters();
    showRemainingTime();
});

