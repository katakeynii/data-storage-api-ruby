module Router
    class Registry
        attr_reader :routes
        def initialize
            @routes = {}
        end

        def add path, request_method, to_controller
            name = get_name to_controller
            route = Route.new(path, request_method, to_controller)
            routes[name] = route
        end


    end
end