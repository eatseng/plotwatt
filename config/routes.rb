Plotwatt::Application.routes.draw do
  root :to => "meters#index"
  namespace "api", :defaults => { :format => :json } do
    get "data", :to => "meters#data"
  end
end
