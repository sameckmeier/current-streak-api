Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api do
    post "/user", to: "users#create"
    post "/sessions", to: "sessions#create"
  end
end
