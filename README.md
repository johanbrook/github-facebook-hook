## Why

In a project we have this private Facebook group for random links and notifications. Instead of sending annoying e-mails to every group member whenever somebody makes a `git push` to our GitHub repo, I created a simple service that posts post receive hook information to that Facebook group's wall instead.

## How

The service is a simple Sinatra server which uses the [Koala gem](https://github.com/arsduo/koala) for Facebook's Graph API.

Download this web service and install dependencies (uses Bundler).

	git clone git://github.com/johanbrook/github-facebook-hook.git
	cd github-facebook-hook
	bundle install

You need a Facebook app and an "Access Token" in order to post with the Graph API. Read more in the [Authentication info](http://developers.facebook.com/docs/authentication/#applogin) at Facebook. I recommend scanning through some [Facebook API reference](http://developers.facebook.com/docs/reference/api/) as well.

A neat way of generating an Access Token is to visit Facebook's [Graph API Explorer](http://developers.facebook.com/tools/explorer) and generate from there.

When you have your token, add it to `keys-sample.rb` and rename that file to `keys.rb`.

	module Keys
		ACCESS_TOKEN = "<your token here>"
	end

Be sure to change the require in `app.rb` to `require "./keys"` instead of `keys-sample`.

Check that everything works.

	ruby app.rb
	open http://localhost:4567

You should see a "Nothing here" text.

Now create a free Heroku app to host the web service (if you have another server, skip this step).

	heroku create <appname> --stack cedar
	git remote add heroku git@heroku.com:<appname>.git

Add the access token as a Heroku environment variable.

	heroku config:add FB_ACCESS_TOKEN=<your token>

When that's done, grab the URL to your Heroku app (something like `http://<appname>.herokuapp.com`).

Next, go the the GitHub repo you want to **watch**, and choose "Admin" > "Service Hooks" > "Post Receive URLs". Add the URL to your Heroku app and append `/facebook`.

	http://<appname>.herokuapp.com/facebook

Press "Update Settings".

**Done!**

Whenever somebody **pushes** to the GitHub repo, your web service on Heroku will receive a POST request, and pass that along to a Facebook group's wall with the Graph API. Neat, eh?