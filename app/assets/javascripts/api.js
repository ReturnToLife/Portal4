
var api_url = 'http://paysdu42:3000/';

function        error_shower(type, message, content) {
    $("#content").html('<h1>Error ' + type + '</h1>'
		       + '<h3>' + message + '</h3>'
		       + '<p>' + content + '</p>');
    $("content").show();
}

function        default_callback_error(event, request) {
    error_shower('404', 'Not Found', 'The page you requested cannot be load. The return API is probably down.');
}

function        wsquery(url, callback, type, callback_error) {
    type = typeof type !== 'undefined' ? type : 'GET'; // default value
    callback_error = typeof callback_error !== 'undefined' ? callback_error : default_callback_error; // default value

    $.jsonp({
            type: type,
            url: api_url + url + '?callback=?',
            data: { format: 'jsonp'},
            dataType: 'jsonp',
	    error: callback_error,
	    success: callback,
            done: (function() { $("content").show(); }),
	    });
}

function        getarticle(id, callback) {
    login = typeof login !== 'undefined' ? type : ''; // default value
    wsquery('articles/' + id, callback);
}

