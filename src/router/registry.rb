module Router
    class Registry
        attr_reader :routes
        def initialize
            @routes = []
        end

        def add request_method, path, to_controller
            route = Route.new(request_method, path, to_controller)
            @routes << route
        end
        
        def find name
            @routes.select{|route| route.name.eql?(name)}.last

        end

        ["get", "post", "put", "delete"].each do |method|
            define_method(method) do |path, to_controller|
                add method, path, to_controller
            end
        end

    end
end