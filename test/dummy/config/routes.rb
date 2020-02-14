Rails.application.routes.draw do
  resources :posts
  root to: 'posts#index'

  post '/upload', to: 'posts#upload'
end
