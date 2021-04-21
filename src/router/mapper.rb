module Router
    class Mapper
        class << self 
            $registry = Router::Registry.new
            def method_missing(method_name, *args)
                $registry.send(method_name, *args)
            end
        end
    end
end