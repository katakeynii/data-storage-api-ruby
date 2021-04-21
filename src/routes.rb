class Routes < Router::Mapper
    # ===> 
    # List of all routes definitions
    # 
    get '/', "HomeController#index"
    put '/data/:name', "RepositoryController#create"
    get '/data/:name/:object_id', "RepositoryController#get_object"
    delete '/data/:name/:object_id', "RepositoryController#destroy"
end