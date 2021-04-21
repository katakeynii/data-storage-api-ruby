#!/usr/bin/env ruby
# Usage:
#
# $ ruby rack-server.rb
require 'rack'
require 'json'
require_relative './src/front_controller'
require_relative './src/router/route'
require_relative './src/router/registry'
require_relative './src/router/mapper'
require_relative './src/router'
require_relative './src/routes'

Dir.glob("src/controllers/**/*.rb").each{ |file_path|
  file_name = File.basename(file_path, ".rb")
  require_relative "./#{file_path}"
}

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
    # Spec 1 : we will have a front controller. The front controller is responsible for taking all upcoming request
    # Spec 2 : We will create a router class. This class will held all route definition of our application. FC will take all routes defined here and find the match and call specific logic controller
    # Spec 3 we will logic controller (LC) that a responsible for responding to client specific demand
    # FLOW :
    req = Rack::Request.new(env)
    request_method = env['REQUEST_METHOD']
    FrontController.handle request_method, path, req

  end
end

# This starts the server if the script is invoked from the command line. No
# modifications needed here.
if __FILE__ == $0
  app = Rack::Builder.new do
    use Rack::Reloader
    run DataStorageServer.new
  end.to_app
  $database = {}
  Rack::Server.start(app: app, Port: 8282)
end