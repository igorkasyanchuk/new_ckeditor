module NewCkeditor
  class Engine < ::Rails::Engine

    initializer 'rails_db.assets_precompile', :group => :all do |app|
      app.config.assets.precompile += [
        'new_ckeditor/*',
        'new_ckeditor/**/*'
      ]
    end

    initializer 'new_ckeditor.helpers' do
      ActiveSupport.on_load :action_view do
        ActionView::Base.send :include, NewCkeditor::RailsExt::ViewHelper
        ActionView::Base.send :include, NewCkeditor::RailsExt::FormHelper
        ActionView::Helpers::FormBuilder.send :include, NewCkeditor::RailsExt::FormBuilder
      end
    end

    initializer 'ckeditor.addons' do
      require 'new_ckeditor/addons/simple_form' if Object.const_defined?('SimpleForm')
    end

  end
end
