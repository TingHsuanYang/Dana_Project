$(document).ready(function () {

    $(".col-4 > div.ui.basic.buttons > button:nth-child(2)").click(function () {
        if ($(".collection").css('font-weight') == 900) {
            $(".collection").css('font-weight', '400');
            $(".collection").css('color', 'black');
        } else {
            $(".collection").css('font-weight', '900');
            $(".collection").css('color', 'red');
        }
    });

    $(window).scroll(function () {
        if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
            $("#myBtn").fadeIn("slow");
        } else {
            $("#myBtn").fadeOut("slow");
        }
    });

    $("#myBtn").click(function () {
        $('html,body').animate({
            scrollTop: 0
        }, 'slow');
    });

});
