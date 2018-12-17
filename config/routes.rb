Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "/login" => "login#create"
      post "/users/addPlaylist" => "users#addPlaylist"
      post "/users/addSongToPlaylist" => "users#addSongToPlaylist"
      post "/users/browserBar" => "users#browserBar"
      get "/users" => "users#create"
      resources :rooms
      resources :tracks

    end
  end
end
