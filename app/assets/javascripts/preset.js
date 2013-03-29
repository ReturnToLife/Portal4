
function        getwidth() {
    return width = window.innerWidth
        || html.clientWidth
        || body.clientWidth
        || screen.availWidth;
}

function        getheight() {
    return height = window.innerHeight
        || html.clientHeight
        || body.clientHeight
        || screen.availHeight;
}

function        setheight() {
    $("#side").css('min-height', getheight());
}

function        fontsizefromwidth(width) {
    return (width/(130/1.2)) + 'em';
}

function        menusettings() {
    // display text on buttons or not?
    if ($("#menu").width() < 100) {
        $(".content").hide();
        $(".separator").hide();
        $(".button").width($(".button").height());
        $(".button").css('margin-left', ($("#menu").width() / 2) - ($(".button").outerWidth() / 2));
    } else {
            $(".content").show();
        $(".separator").show();
        $(".button").width('');
        $(".button").css('margin-left', '');
    }
    // change button font
    var fontsize = fontsizefromwidth($(".button").width());
    $(".button").css('font-size', fontsize);
    $(".separator").css('font-size', fontsize);
}

function        homesettings() {
    // height of the four squares
    var h = $("#articles_showcase").height();
    var h = $(window).height();
    $(".square").height((h / 2) - (h * 0.02));
    // heart in the middle
    $("#heart").hide();
    //    $("#heart").css('left', $("#articles_showcase").position().left + ($("#articles_showcase").width() / 2) - 12);
    //    $("#heart").css('top', $("#articles_showcase").position().top + (h / 2) - 11);
}

function        resetsizes() {
    $(document).hide();
    setheight();
    menusettings();
    $(document).show();
    // at the very end, change the menu size
    $("#menu").css('min-height', $(document).height());
}

function        presetsizes() {
    window.onresize = resetsizes;
    resetsizes();
    homesettings();
}

function	presetbootstrapjs() {
    $(window).load(function() {
	    $('.badge-tooltip').tooltip({
		    html: true,
			});
	});
}

presetsizes();
presetbootstrapjs();
