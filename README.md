## Dispatch ##

### Capistrano deployment with a button ###

#### Setup & Go ####

	mkdir projects
	mkdir projects/YOUR_PROJECT_NAME
	# add deploy.rb and deploy/{staging/production/integration/etc}.rb

	thin -d -R config.ru -e production start # defaults to port 3000
	APP_ENV=production ruby lib/server.rb

Crack open localhost:3000 (or whatever server you want) and enjoy!

If the websocket server is not running, the logo will be grey.
Don't worry! The websocket will reconnect when the server is restarted.

If started without APP\_ENV, Dispatch websocket server starts in development
and will not actually deploy applications.

### Why? ###

* I like the culture of having a button for a team to deploy from.
* I wanted to mess with websockets, mostly
