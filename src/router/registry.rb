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
        
        def match request_method, path
            match_method = @routes.select{|route| route.request_method.upcase.eql?(request_method)}
            to_dispatch = nil
            match_method.each do |route|
                path_array = path.split("/")
                route_path_array = route.path.split('/')
                next unless path_array.size.eql?(route_path_array.size)
                params = {}
                route_path_array.each_with_index do |x, i|
                    if route.is_parameter?(x)
                        params[x[1..-1].to_sym] = path_array[i]
                    end
                end
                to_dispatch = {
                    route: route,
                    params: params
                }
                break
            end
            to_dispatch

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