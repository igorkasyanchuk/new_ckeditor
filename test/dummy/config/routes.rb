Rails.application.routes.draw do
  mount NewCkeditor::Engine => '/ckeditor'

  resources :projects
  resources :users
  resources :posts
  root to: 'posts#index'

#  post '/upload', to: 'posts#upload'
end
