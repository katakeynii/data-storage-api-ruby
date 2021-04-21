class Routes < Router::Mapper
    
    get '/', "HomeController#index"
    get '/data/:name', "RepositoryController#create"
    get '/data/:name/:object_id', "RepositoryController#get_object"
end