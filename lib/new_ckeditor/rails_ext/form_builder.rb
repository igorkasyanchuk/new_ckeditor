module NewCkeditor
  module RailsExt
    module FormBuilder
      extend ActiveSupport::Concern

      def ckeditor(method, options = {})
        @template.ckeditor(@object_name, method, objectify_options(options))
      end
    end
  end
end