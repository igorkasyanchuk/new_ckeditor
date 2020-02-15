Rails.application.routes.draw do
  post '/upload', to: 'new_ckeditor/uploads#upload'
end
