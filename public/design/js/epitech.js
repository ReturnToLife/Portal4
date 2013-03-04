
var intra_url = 'https://intra.epitech.bigint.fr/intra/';

function        error_shower(type, message, content) {
    $("#content").html('<h1>Error ' + type + '</h1>'
		       + '<h3>' + message + '</h3>'
		       + '<p>' + content + '</p>');
    console.log("hello");
    $("content").show();
}

function        default_callback_error(event, request) {
    error_shower('404', 'Not Found', 'The page you requested cannot be load. Check if:<ul><li>You\'re logged in the Epitech Intranet ('
		 + '<a href="' + intra_url + '">' + intra_url
		 +'</a>)</li><li>The URL is correct</li><li>The information you asked for are valid</li></ul>');
}

function        wsquery(url, callback, type, callback_error) {
    type = typeof type !== 'undefined' ? type : 'GET'; // default value
    callback_error = typeof callback_error !== 'undefined' ? callback_error : default_callback_error; // default value

    $.jsonp({
            type: type,
            url: intra_url + url + '?callback=?',
            data: { format: 'jsonp'},
            dataType: 'jsonp',
	    error: callback_error,
	    success: callback,
            done: (function() { $("content").show(); }),
	    });
}

function        getuser(login, callback) {
    wsquery('user/' + login, callback);
}

