function onClickOfMoreLink(moreText, lessText) {
    $(".morelink").click(function () {
        if ($(this).hasClass("less")) {
            $(this).removeClass("less");
            $(this).html(moreText);
        } else {
            $(this).addClass("less");
            $(this).html(lessText);
        }
        $(this).parent().prev().toggle();
        $(this).prev().toggle();
        return false;
    });
}

function passageContent(defaultPreviewLimit, indication, moreText) {
    $('.more').each(function () {
        var content = $(this).html();
        if (content.length > defaultPreviewLimit) {

            var preview = content.substr(0, defaultPreviewLimit);
            var actualContent = content.substr(defaultPreviewLimit, content.length - defaultPreviewLimit);

            var html = preview + '<span>' + indication + '&nbsp;</span><span class="morecontent"><span>' + actualContent + '</span>&nbsp;&nbsp;<a href="" class="morelink">' + moreText + '</a></span>';

            $(this).html(html);
        }

    });
}

document.addEventListener("turbolinks:load", function () {
    var defaultPreviewLimit = 100;
    var indication = "...";
    var moreText = "Show More";
    var lessText = "Show Less";

    passageContent(defaultPreviewLimit, indication, moreText);

    onClickOfMoreLink(moreText, lessText);
});