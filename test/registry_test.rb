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
  
end