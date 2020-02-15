module NewCkeditor
  module RailsExt
    module ViewHelper
      extend ActiveSupport::Concern

      def ckeditor_tag(name, content = nil, options = {})
        NewCkeditor::Editor.new(self, options).render_tag(name, content)
      end

    end
  end
end