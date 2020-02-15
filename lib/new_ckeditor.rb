require "new_ckeditor/engine"
require "carrierwave"

module NewCkeditor
  autoload :Editor, 'new_ckeditor/editor'

  module RailsExt
    autoload :ViewHelper,  'new_ckeditor/rails_ext/view_helper.rb'
    autoload :FormHelper,  'new_ckeditor/rails_ext/form_helper.rb'
    autoload :FormBuilder, 'new_ckeditor/rails_ext/form_builder.rb'
  end

  module Addons
    autoload :SimpleFormBuilder, 'new_ckeditor/addons/simple_form'
  end
end
