class FrontController
    # The front controller is responsible for receiving all incoming HTTP request 
    # After receiving it the front controller check the matched routes and dispatch the controller of it 
    class << self 
        def handle request_method, path, req 
            # 1 get the registry
            matched = $registry.match request_method, path
            if matched.nil?
                [404, {}, ["#{path} not found "]]
            else
                route = matched[:route]
                params = matched[:params]
                dispatch(route, params, req)
            end
        end

        # Dispatch a controller action
        
        def dispatch route, params = nil, req
            target = route.controller.split("#")
            klass = Object.const_get target.first
            instance = klass.new
            instance.params = params
            instance.url_params = req.params
            instance.send(target.last)
        end
    end
end