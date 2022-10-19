Rails.application.routes.draw do
  post 'visits/visited_links'
  get 'visits/visited_domains'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
