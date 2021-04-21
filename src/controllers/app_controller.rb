class AppController
    attr_accessor :params
    attr_accessor :url_params
    def params 
        @params ||= []
    end
    def render content, status = 200, headers = {}
        [status.to_s, headers, [content]]
    end
    
end