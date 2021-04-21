require "minitest/autorun"
require_relative '../src/router'
require_relative '../src/router/route'
class RouteTest < Minitest::Test

    def test_correct_route
      @home_route = Router::Route.new "get", "/", "HomeController#home"
      assert_instance_of Router::Route, @home_route
      assert_equal @home_route.path, "/"
      assert_raises RuntimeError do 
         Router::Route.new "set", "/", "HomeController"
      end
    end

    def test_route_name
        @home_route = Router::Route.new "get", "/", "HomeController#index"
        assert_equal @home_route.name, "get_home_controller_index" 
    end
  
end