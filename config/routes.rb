Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api do
    post "/user", to: "users#create"
    post "/user/game_events", to: "users#create_game_event"
    post "/sessions", to: "sessions#create"
    get "/games", to: "games#index"
  end
end
