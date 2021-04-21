class AppController
    attr_accessor :params
    def params 
        @params ||= []
    end
    def render content, status = 200
        [status, {}, [content]]
    end
    
end