
var user = 'lepage_b';

function        displayuserprofile(userinfo) {
    $("#login").html(userinfo.login);
    $("#name").html(userinfo.title);
    $("#promo").html(userinfo.promo);
    $("#city").html(userinfo.location);
    $("#contact").attr('href', 'mailto:' + userinfo.internal_email);
    $("#intranet").attr('href', intra_url + 'user/' + userinfo.login);
    $("#photo").attr('src', userinfo.picture);
}

getuser(user, displayuserprofile);
