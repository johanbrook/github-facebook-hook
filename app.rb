require 'rubygems'
require 'sinatra'
require 'koala'
require 'json'

GROUP_ID = "264520473627892"

configure :production do
  TOKEN = ENV['FB_ACCESS_TOKEN']
end

configure :development do
  require './keys-sample'
  TOKEN = Keys::ACCESS_TOKEN
end

graph = Koala::Facebook::API.new(TOKEN)

get '/' do
  "Nothing here"
end


post "/facebook" do
  push = JSON.parse(params[:payload])
  
  caption = sprintf "%s file(s) modified, %s added, %s removed", 
    push["head_commit"]["modified"].length, 
    push["head_commit"]["added"].length, 
    push["head_commit"]["removed"].length
  
  ref = push['ref'].split("/").last
    
  post = {
    :link => push["repository"]["url"]+"/commits/"+ref,
    :name => sprintf("HEAD is now %s", push["after"][0..7]),
    :description => push["head_commit"]["message"],
    :caption => caption
  }
  
  msg = sprintf("%s pushed new stuff to %s (%s commit(s))",
          push["pusher"]["name"].split.first, 
          ref,
          push['commits'].length)
          
    # Only post pushes made to master
    graph.put_wall_post(msg, post, GROUP_ID) if ref == "master"
end
