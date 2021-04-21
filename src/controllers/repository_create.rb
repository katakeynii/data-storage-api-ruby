class RepositoryController < AppController
    
    def create
        data = @url_params.map{|k,v| "#{k}#{v}"}.join('&')
        oid = data.tr(" ", "-")
        response = {
            oid: data.tr(" ", "-"),
            size: data.size            
        }
        object = response
        object[:data] = data
        $database[params[:name]] ||= {}
        $database[params[:name]][oid] = object
        render response.to_json, 201, {"Content-Type" => "application/json"}
    end
    def get_object
        repo = $database[params[:name]]
        if repo.nil?
            render "Page not found", 404
        else
            obj = $database[params[:name]][params[:object_id]]

            if obj.nil? 
                render "Not found", 404
            else
                render obj[:data], 200
            end
        end
    end

    def destroy

        repo = $database[params[:name]]
        if repo.nil?
            render "Not found", 404
        else
             obj = $database[params[:name]][params[:object_id]]

            if obj.nil? 
                render "Not found", 404
            else
                $database[params[:name]].delete(params[:object_id])
                render "Destroyed", 200
            end
        end
        
    end
end