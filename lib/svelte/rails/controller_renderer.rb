require 'svelte/rails/view_helper'

module Svelte
  module Rails
    class ControllerRenderer
      include Svelte::Rails::ViewHelper
      # include ActionView::Helpers::TagHelper
      # include ActionView::Helpers::TextHelper

      attr_accessor :output_buffer

      # @return [String] HTML for `component_name` with `options[:props]`
      def call(component_name, options, &block)
        props = options.fetch(:props, {})
        options = default_options.merge(options.slice(:data, :aria, :tag, :class, :id, :prerender, :camelize_props))
        svelte_component(component_name, props, options, &block)
      end

      private

      def default_options
        { prerender: true }
      end
    end
  end
end
