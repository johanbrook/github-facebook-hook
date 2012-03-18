require 'rubygems'
require 'sinatra'
require 'koala'
require 'json'

APP_ID =      "113890745407534"
APP_SECRET =  "2025b11fd4ff299f625d3cb801160b49"
GROUP_ID =    "264520473627892"

graph = Koala::Facebook::API.new("AAABnlUFsWC4BAMCGpPSvrScl6swYSnUaWqPeSsN2iDpb6FAGiVsEA8NNHZCgb13vbvXN6GvJG7CdoFCxTE1vmYaOZCfdZCBrgLWUiNfhwZDZD")

#AAABnlUFsWC4BAMCGpPSvrScl6swYSnUaWqPeSsN2iDpb6FAGiVsEA8NNHZCgb13vbvXN6GvJG7CdoFCxTE1vmYaOZCfdZCBrgLWUiNfhwZDZD
#AAABnlUFsWC4BAMCGpPSvrScl6swYSnUaWqPeSsN2iDpb6FAGiVsEA8NNHZCgb13vbvXN6GvJG7CdoFCxTE1vmYaOZCfdZCBrgLWUiNfhwZDZD
#113890745407534|we9wLxU0hgAHnP0MWnL_YopJAW4


get '/' do
  
  msg = <<-JSON
    {
      "pusher": {
        "name": "Johan Brook",
        "username": "johanbrook"
      },
      "before": "5aef35982fb2d34e9d9d4502f6ede1072793222d",
      "repository": {
        "url": "http://github.com/defunkt/github",
        "name": "github",
        "description": "You're lookin' at it.",
        "watchers": 5,
        "forks": 2,
        "private": 1,
        "owner": {
          "email": "chris@ozmm.org",
          "name": "defunkt"
        }
      },
      "commits": [
        {
          "id": "41a212ee83ca127e3c8cf465891ab7216a705f59",
          "url": "http://github.com/defunkt/github/commit/41a212ee83ca127e3c8cf465891ab7216a705f59",
          "author": {
            "email": "chris@ozmm.org",
            "name": "Chris Wanstrath"
          },
          "message": "okay i give in",
          "timestamp": "2008-02-15T14:57:17-08:00",
          "added": ["filepath.rb"]
        },
        {
          "id": "de8251ff97ee194a289832576287d6f8ad74e3d0",
          "url": "http://github.com/defunkt/github/commit/de8251ff97ee194a289832576287d6f8ad74e3d0",
          "author": {
            "email": "chris@ozmm.org",
            "name": "Chris Wanstrath"
          },
          "message": "update pricing a tad",
          "timestamp": "2008-02-15T14:36:34-08:00"
        }
      ],
      "after": "de8251ff97ee194a289832576287d6f8ad74e3d0",
      "ref": "refs/heads/master",
      
      "head_commit" :  {
          "modified" : ["test.txt"],
          "added" : ["test2.txt"],
          "author" : {
              "name" : "Johan Brook",
              "username" : "johanbrook",
              "email" : "johan.jvb@gmail.com"
          },
          "timestamp" : "2012-03-18T12:11:53-07:00",
          "removed" : [],
          "url" : "https://github.com/johanbrook/gh-hooks-testrepo/commit/9a77c77f1e9ce63e7ac0d894a1b8179176bdd615",
          "id" : "9a77c77f1e9ce63e7ac0d894a1b8179176bdd615",
          "distinct" :  true,
          "message" :  "5th commit"
        }
    }
  
  JSON
  
  push = JSON.parse msg
  
  caption = sprintf "%s file(s) modified, %s added, %s removed", 
    push["head_commit"]["modified"].length, 
    push["head_commit"]["added"].length, 
    push["head_commit"]["removed"].length
  
  post = {
    :message => sprintf("%s pushed new stuff to %s", push["pusher"]["name"].split.first, push["ref"]),
    :link => push["repository"]["url"]+"/commits",
    :name => sprintf("HEAD is now %s", push["after"][0..7]),
    :description => push["head_commit"]["message"],
    :caption => caption
  }
  
  post.inspect
end


post "/facebook" do
  push = JSON.parse(params[:payload])
  
  post = {
    :message => sprintf("%s pushed new stuff to %s", push["pusher"]["name"].split.first, push["ref"]),
    :link => push["repository"]["url"]+"/commits",
    :name => sprintf("HEAD is now %s", push["after"][0..7]),
    :description => push["head_commit"]["message"],
    :caption => caption
  }
  
  msg = sprintf "%s pushed new stuff to %s", push["pusher"]["name"].split.first, push["ref"]
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