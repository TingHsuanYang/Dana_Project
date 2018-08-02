$(document).ready(function () {

    $("body > div.ui.container > div > a > div > div > img").error(function () {
        $(this).attr("src", "https://travel98.com/images/blank_image/Default_Avatar.png");
    });

    $('[data-content="建立文章遊記"]').popup();

    $(".item").click(function () {
        if (!$(this).hasClass('dropdown browse')) {
            $(this)
                .addClass('active')
                .closest('.ui.menu')
                .find('.item')
                .not($(this))
                .removeClass('active');
        }
    });

});
