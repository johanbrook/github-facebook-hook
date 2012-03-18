require 'rubygems'
require 'sinatra'
require 'koala'
require 'json'

APP_ID =      "113890745407534"
APP_SECRET =  "2025b11fd4ff299f625d3cb801160b49"
GROUP_ID =    "264520473627892"

graph = Koala::Facebook::API.new("AAABnlUFsWC4BAM2AT4u7jRyokOrfHQDlejB0jkEJK1hvVYp55KRGwfQVzUqfEh6VUHpVBh0kfgDDhyZBR3nCjFgxZAd0GX0QKe4xapKAZDZD")

#AAABnlUFsWC4BAMCGpPSvrScl6swYSnUaWqPeSsN2iDpb6FAGiVsEA8NNHZCgb13vbvXN6GvJG7CdoFCxTE1vmYaOZCfdZCBrgLWUiNfhwZDZD
#AAABnlUFsWC4BAMCGpPSvrScl6swYSnUaWqPeSsN2iDpb6FAGiVsEA8NNHZCgb13vbvXN6GvJG7CdoFCxTE1vmYaOZCfdZCBrgLWUiNfhwZDZD
#113890745407534|we9wLxU0hgAHnP0MWnL_YopJAW4


get '/' do
  
  "Nothing here."
end


post "/facebook" do
  push = JSON.parse(params[:payload])
  
  caption = sprintf "%s file(s) modified, %s added, %s removed", 
    push["head_commit"]["modified"].length, 
    push["head_commit"]["added"].length, 
    push["head_commit"]["removed"].length
    
  post = {
    :link => push["repository"]["url"]+"/commits",
    :name => sprintf("HEAD is now %s", push["after"][0..7]),
    :description => push["head_commit"]["message"],
    :caption => caption
  }
  
  msg = sprintf("%s pushed new stuff to %s", push["pusher"]["name"].split.first, push["ref"])
  ret = graph.put_wall_post(msg, post, GROUP_ID)
  puts ret["id"]
end

# Test at <appname>.heroku.com

# You can see all your app specific information this way.
# IMPORTANT! This is a very bad thing to do for a production
# application with sensitive information

# get '/env' do
#   ENV.inspect
#end