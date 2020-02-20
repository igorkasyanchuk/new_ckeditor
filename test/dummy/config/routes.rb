Rails.application.routes.draw do
  mount NewCkeditor::Engine => '/ckeditor'

  resources :projects do
    put :update_inline, on: :member
  end
  resources :users
  resources :posts

  root to: 'posts#index'
end
