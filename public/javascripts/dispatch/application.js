var DIS = DIS || {};

DIS = $.extend({}, DIS, {
	common: {
		init: function() {
			$("body").noisy();
			// pull cruise rss feed for each of the rows
			// set class failed for any row that has failed
			// set class passed for any row that has passed, which causes the buttons to show

			// establish websocket
			// if websocket, add click functions to buttons to call the websocket to deploy with 
			// add class to row to indicate we are deploying, presently
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