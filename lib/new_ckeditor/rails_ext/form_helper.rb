module NewCkeditor
  module RailsExt
    module FormHelper
      extend ActiveSupport::Concern

      def ckeditor(object_name, method, options = {})
        NewCkeditor::Editor.new(self, options).render_instance_tag(object_name, method)
      end
    end
  end
end