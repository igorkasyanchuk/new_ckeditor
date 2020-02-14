module NewCkeditor
  class Engine < ::Rails::Engine

    initializer 'rails_db.assets_precompile', :group => :all do |app|
      app.config.assets.precompile += [
        # 'new_ckeditor/application.js',
        # 'new_ckeditor/application.css',
        'new_ckeditor/*',
        'new_ckeditor/**/*'
      ]
    end

  end
end
