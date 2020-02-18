require 'active_support'
require 'action_view/helpers/tag_helper'
require 'action_view/helpers/form_tag_helper'
require 'action_view/helpers/javascript_helper'

module NewCkeditor
  class Editor
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::FormTagHelper
    include ActionView::Helpers::JavaScriptHelper

    attr_reader :template, :options

    def initialize(template, options)
      @template = template
      options.delete(:required) # to avoid bug of validating empty textarea
      @options = options.deep_stringify_keys!
    end

    def render_instance_tag(object_name, method)
      tag = build_instance_tag(object_name, method)
      tag.send(:add_default_name_and_id, options) if options['id'].blank?
      render(tag.respond_to?(:to_text_area_tag) ? tag.to_text_area_tag(options) : tag.render, options)
    end

    def render_tag(name, content)
      options['id'] = sanitize_to_id(options['id'] || name)
      tag = build_tag(name, content, options)
      render(tag, options)
    end

    protected

    def render(input, options)
      result = ActiveSupport::SafeBuffer.new
      result << input
      result << @template.render("/new_ckeditor/shared/#{editor_template}", id: options["id"], options: options)
      result
    end

    def editor_type
      options.dig("editor", "type") || "classic"
    end

    def editor_template
      options.dig("editor", "template") || "classic"
    end

    def build_instance_tag(object_name, method)
      if editor_type.to_s == "classic"
        ActionView::Base::Tags::TextArea.new(object_name, method, template, options.symbolize_keys)
      else
        ActionView::Base::Tags::HiddenField.new(object_name, method, template, options.symbolize_keys)
      end
    end

    def build_tag(name, content, options)
      if editor_type.to_s == "classic"
        text_area_tag(name, content, options)
      else
        hidden_field_tag(name, content, options)
      end
    end
  end
end