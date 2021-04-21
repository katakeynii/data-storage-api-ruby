#!/usr/bin/env ruby
# Usage:
#
# $ ruby rack-server.rb
require 'rack'
require 'json'

class DataStorageServer
  # You may initialize any variables you want to use across requests here
  def initialize
    @storage = {}
  end

  # Download an Object
  #
  # GET /data/{repository}/{objectID}
  # Response
  #
  # Status: 200 OK
  # {object data}
  # Objects that are not on the server will return a 404 Not Found.
  def get(path)
    ['200', {}, ["hello from get #{path}"]]
  end


  def call(env)
    path = env['PATH_INFO']
    case env['REQUEST_METHOD']
    when 'GET'
      get(path)
    end
  end
end

# This starts the server if the script is invoked from the command line. No
# modifications needed here.
if __FILE__ == $0
  app = Rack::Builder.new do
    use Rack::Reloader
    run DataStorageServer.new
  end.to_app

  Rack::Server.start(app: app, Port: 8282)
end