class RepositoryController < AppController
    
    def create
        puts params.inspect
        render "LE Repo = #{params[:name]}"
    end
    def get_object
        render "LE Repo = #{params[:name]} + OBJECT : #{params[:object_id]}"
    end
end