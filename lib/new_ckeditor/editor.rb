require 'active_support'
require 'action_view/helpers/tag_helper'
require 'action_view/helpers/form_tag_helper'
require 'action_view/helpers/javascript_helper'

module NewCkeditor
  class Editor
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::FormTagHelper
    include ActionView::Helpers::JavaScriptHelper

    attr_reader :template, :options, :ck_options

    def initialize(template, options)
      @template = template
      options.delete(:required) # to avoid bug of validating empty textarea
      @options  = options.stringify_keys
    end

    def render_instance_tag(object_name, method)
      tag = build_tag(object_name, method)
      tag.send(:add_default_name_and_id, options) if options['id'].blank?

      render(tag.respond_to?(:to_text_area_tag) ? tag.to_text_area_tag(options) : tag.render, options)
    end

    def render_tag(name, content)
      options['id'] = sanitize_to_id(options['id'] || name)

      render text_area_tag(name, content, options), options
    end

    protected

    def render(input, options)
      output_buffer << input
      output_buffer << @template.render('/new_ckeditor/shared/editor', id: options["id"], editor: editor)
      output_buffer
    end

    def editor
      #"InlineEditor"
      #"BalloonEditor"
      "ClassicEditor"
    end

    def output_buffer
      @output_buffer ||= ActiveSupport::SafeBuffer.new
    end

    def build_tag(object_name, method)
      if defined?(ActionView::Base::Tags::TextArea)
        ActionView::Base::Tags::TextArea.new(object_name, method, template, options.symbolize_keys)
      else
        ActionView::Base::InstanceTag.new(object_name, method, template, options.delete('object'))
      end
    end
  end
end