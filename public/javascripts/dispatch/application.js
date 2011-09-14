var DIS = DIS || {};

DIS.logging = true;
DIS.log = function(msg) {
	if(DIS.logging) console.log(msg);
}

DIS.socket = undefined;
DIS.socket_open = false;

// add class to row to indicate we started deploying, given message
// add class to row to indicate we completed deploying, given message
DIS.handle_socket_event = function(evt) {
	var data = JSON.parse(evt.data);

	// if(!data) {return}

	DIS.log(data);

	if(data['status'] == 'complete') {
		// DIS.log(data['log']);
	}

	if(data['status'] == 'started') {}
}

DIS.handle_socket_open = function() {
	$('a[data-project-name]').bind('click', function(e) {
		e.preventDefault();

		var $this = $(this),
				project_name = $this.data('project-name'),
				stage = $this.data('stage');

		var msg = JSON.stringify({'name':project_name, 'stage':stage});
		DIS.message_socket(msg);
	})

	$('h1.logo').removeClass('closed').addClass('open');
}

DIS.handle_socket_close = function() {
	$('h1.logo').removeClass('open').addClass('closed');

	// reconnect?
}

DIS.message_socket = function(msg) {
	if(DIS.socket === undefined) { DIS.log("Socket Undefined"); return }
	if(!DIS.socket_open) { DIS.log("Socket Not Open"); return }

	DIS.socket.send(msg);
}

DIS.create_socket = function(socket_url, m, o, c) {
	if(!("WebSocket" in window)) { alert("Sorry, WebSockets unavailable."); return }

		// do we need to handle undefining this, if the socket closes?
		DIS.socket = new WebSocket(socket_url);

		DIS.socket.onmessage = m;
		DIS.socket.onopen = function() {DIS.socket_open = true; DIS.log("Socket Open"); o();}
		DIS.socket.onclose = function() {DIS.socket_open = false; DIS.log("Socket Closed"); c();}
}

DIS = $.extend({}, DIS, {
	common: {
		init: function() {
			$("body").noisy();

			// pull cruise rss feed for each of the rows
			// set class failed for any row that has failed
			// set class passed for any row that has passed, which causes the buttons to show

			// establish websocket
			DIS.create_socket(
				$('meta[name="websocket-url"]').attr("content"),
				DIS.handle_socket_event,
				DIS.handle_socket_open,
				DIS.handle_socket_close
			);
		}
	}
});

UTIL = {
	exec: function( controller, action ) {
		var ns = DIS,
			action = ( action === undefined ) ? "init" : action;

		if ( controller !== "" && ns[controller] && typeof( ns[controller][action] ) == "function" ) {
			ns[controller][action]();
		}
	},

	init: function() {
		var body = document.body, controller = body.getAttribute( "data-controller" ), action = body.getAttribute( "data-action" );

		UTIL.exec( "common" );
		// UTIL.exec( controller );
		// UTIL.exec( controller, action );

		$(document).trigger('finalized');
	}
};

$(document).ready( UTIL.init );