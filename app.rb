require 'rubygems'
require 'sinatra'
require 'koala'
require 'json'

APP_ID =      "113890745407534"
APP_SECRET =  "2025b11fd4ff299f625d3cb801160b49"
GROUP_ID =    "264520473627892"

#oauth = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, "http://medioqre-notifier.herokuapp.com")

graph = Koala::Facebook::API.new("AAABnlUFsWC4BAMCGpPSvrScl6swYSnUaWqPeSsN2iDpb6FAGiVsEA8NNHZCgb13vbvXN6GvJG7CdoFCxTE1vmYaOZCfdZCBrgLWUiNfhwZDZD")

#AAABnlUFsWC4BAMCGpPSvrScl6swYSnUaWqPeSsN2iDpb6FAGiVsEA8NNHZCgb13vbvXN6GvJG7CdoFCxTE1vmYaOZCfdZCBrgLWUiNfhwZDZD
#AAABnlUFsWC4BAMCGpPSvrScl6swYSnUaWqPeSsN2iDpb6FAGiVsEA8NNHZCgb13vbvXN6GvJG7CdoFCxTE1vmYaOZCfdZCBrgLWUiNfhwZDZD
#113890745407534|we9wLxU0hgAHnP0MWnL_YopJAW4

# MAIN
get '/' do
#  graph.put_wall_post "Deployed", {
#    :name => "Test",
#    :message => "Testing"
#  }, GROUP_ID

end


post "/facebook" do
  push = JSON.parse params[:payload]
  puts "Something happened"
  puts push.inspect
end

# Test at <appname>.heroku.com

# You can see all your app specific information this way.
# IMPORTANT! This is a very bad thing to do for a production
# application with sensitive information

# get '/env' do
#   ENV.inspect
#end