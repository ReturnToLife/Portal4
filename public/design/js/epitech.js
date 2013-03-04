
var intra_url = 'https://intra.epitech.bigint.fr/intra/';

function        default_callback_error(event, request, settings) {
    // todo: not working with JSONP
    $("#content").html('<h1>Error</h1><p>' + event + '<br>'
                      + request + '<br>' + settings + '</p>');
}

function        wsquery(url, callback, type, callback_error) {
    a = typeof a !== 'undefined' ? a : 'GET'; // default value
    a = typeof a !== 'undefined' ? a : default_callback_error; // default value

    $.ajax({
            type: type,
            url: intra_url + url + '?callback=?',
            data: { format: 'jsonp'},
            dataType: 'jsonp',
           }).done(callback);
    $(document).ajaxError(callback_error);
}

function        getuser(login, callback) {
    wsquery('user/' + login, callback);
}

