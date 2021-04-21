module Router
    class Route
        
        attr_reader :path, :method, :controller, :name
        def initialize request_method, path, controller
            @request_method = request_method
            @path = path 
            @controller = controller
            @name = set_name controller
            raise "unknow http request method #{request_method} " unless["get", "post", "put", "delete"].include?(request_method)
        end
        private 
            def set_name to_controller
                controller_split = controller.split("#")
                action_name = controller_split.last 
                prefix_name = controller_split.first
                    .split("::")
                    .map{|r| underscore(r)}
                    .join("_")
                name = "#{@request_method}_#{prefix_name}_#{action_name}"
            end

            def underscore(word)
                word = word.to_s.gsub("::", "/")
                word.gsub!(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2')
                word.gsub!(/([a-z\d])([A-Z])/, '\1_\2')
                word.tr!("-", "_")
                word.downcase!
                word
            end
    end
end