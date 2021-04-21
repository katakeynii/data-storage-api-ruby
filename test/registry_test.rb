require "minitest/autorun"
require_relative '../src/router'
require_relative '../src/router/route'
require_relative '../src/router/registry'

class RegistryTest < Minitest::Test

    def test_instances
      registry = Router::Registry.new
      registry.add "get", "/", "HomeController#index"
      assert_instance_of Router::Registry, registry
      assert_instance_of Router::Route, registry.routes.first
    end
  
    def test_http_request_method_functions
        registry = Router::Registry.new
        registry.get "/", "HomeController#index"
        assert_instance_of Router::Route, registry.routes.first
    end

    def test_find_route
        registry = Router::Registry.new
        registry.get "/", "HomeController#index"
        registry.post "/register", "Api::V1::RegisterController#index"
        item = registry.find "post_api_v1_register_controller_index"
        assert_instance_of Router::Route, item
    end
end