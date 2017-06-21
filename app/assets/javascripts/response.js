//=require jquery.tagsinput.min

var updateRemainingCharacters = function (event) {
    var charLimit = event.target.maxLength;
    var presentCount = event.target.value.length;
    var totalChars = charLimit - presentCount;
    $('#app-total-chars').html(totalChars);
};

var disableSubmission = function () {
    $(".app-response-submission").attr("disabled", "disabled");
    $(".app-response-submission").css("display", "none");
    $(".back-btn").removeClass("hidden")
    $("#timeout_alert").html('<div class="alert alert-danger"> <strong>Oops..!</strong> Your submission time has been expired..</div>')
    setTimeout(function () {
        $(".alert").alert('close')
    }, 5000);

};

var showRemainingTime = function () {
    var date = new Date();
    var remainingTimeElement = $("#app-remaining-time");
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
    $(".alert").ready(function () {
        setTimeout(function () {
            $(".alert").alert('close')
        }, 4000);
    })
};

document.addEventListener("turbolinks:load", function () {
    showRemainingCharacters();
    showRemainingTime();
    remove_flash_messages();
    initializeTaggings();
    initializeReviewButtions();
});

var initializeTaggings = function () {
    $('.tags').tagsInput({
        'height': '50px',
        'width': '100%',
        'interactive': true,
        'onAddTag': onTagAddition,
        'onRemoveTag': onTagRemoval
    });
};

var requester = function (url, method, data, onSuccess) {
    return $.ajax({
        url: url,
        type: method,
        data: data,
        success: onSuccess
    });
};

var onTagAddition = function (tagName) {
    var uri = 'create_tagging_by_tag_name';
    var method = 'POST';
    var onSuccess = function (res, status) {
        if (status !== 'success')
            deleteTag(self, tagName)
    };
    var self = $(this);
    var response_id = self.attr('data-response-id');
    var url = '/responses/' + response_id + '/taggings/' + uri;
    var data = {tag_name: tagName};
    requester(url, method, data, onSuccess).fail(function () {
        deleteTag(self, tagName)
    });
};

var onTagRemoval = function (tagName) {
    var uri = 'delete_tagging_by_tag_name';
    var method = 'DELETE';
    var onSuccess = function () {
    };
    var self = $(this);
    var response_id = self.attr('data-response-id');
    var url = '/responses/' + response_id + '/taggings/' + uri;
    var data = {tag_name: tagName};
    requester(url, method, data, onSuccess);

};
var deleteTag = function (tags, tag) {
    return tags.removeTag(tag);
};


var onReview = function () {
    console.log('hello......')
    var uri = 'review_taggings';
    var method = 'PUT';
    var onSuccess = function (res, status) {
    };
    var self = $(this);
    var response_id = self.attr('data-response-id');
    var url = '/responses/' + response_id + '/taggings/' + uri;
    var data = {};
    requester(url, method, data, onSuccess);
};

var initializeReviewButtions = function () {
    $('.app-tag-review-btn').on('click', onReview);
};
