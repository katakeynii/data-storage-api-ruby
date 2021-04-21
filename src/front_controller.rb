class FrontController
    class << self 
        def handle request_method, path 
            # 1 get the registry
            puts $registry.routes.inspect
            matched = $registry.match request_method, path
            route = matched[:route]
            params = matched[:params]
            dispatch(route, params)
        end

        def dispatch route, params = nil
            target = route.controller.split("#")
            klass = Object.const_get target.first
            instance = klass.new
            instance.params = params
            instance.send(target.last)
        end
    end
end