var updateRemainingCharacters = function (event) {
    var charLimit = event.target.maxLength;
    var presentCount = event.target.value.length;
    var totalChars = charLimit - presentCount;
    $('#totalChars').html(totalChars);
};

var disableSubmission = function () {
    $(".response-submission").attr("disabled", "disabled");
};

var showRemainingTime = function () {
    var date = new Date();
    var remainingTimeElement = $("#remaining_time");
    var time = remainingTimeElement.html();
    date.setSeconds(time);
    remainingTimeElement
        .countdown(date.toLocaleString(), function (event) {
            $(this).text(
                event.strftime('%H:%M:%S')
            );
            var remaining_time = remainingTimeElement.html();
            if (remaining_time == "00:00:00")
                disableSubmission();
        });
};

var showRemainingCharacters = function () {
    $('#text').on('input', updateRemainingCharacters);
};

var remove_flash_messages = function () {
    $(".alert").ready(function(){
        setTimeout(function(){
            $(".alert").alert('close')
        },4000);
    })
};

document.addEventListener("turbolinks:load", function () {
    showRemainingCharacters();
    showRemainingTime();
    remove_flash_messages();
});