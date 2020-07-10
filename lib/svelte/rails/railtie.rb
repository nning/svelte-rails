require 'rails/railtie'

module Svelte::Rails
  class Railtie < ::Rails::Railtie
    config.svelte = ActiveSupport::OrderedOptions.new

    # Prerender (SSR) by default (i.e. without passing `prerender:true` to the view helper)
    config.svelte.predender_default = false

    initializer 'svelte_rails.setup_view_helpers', after: :load_config_initializers, group: :all do |app|
      ActiveSupport.on_load(:action_view) do
        include ::Svelte::Rails::ViewHelper
      end
    end

    initializer 'svelte_rails.add_component_renderers', group: :all do |app|
      render_component = lambda do |component_name, options|
        renderer = ::Svelte::Rails::ControllerRenderer.new
        html = renderer.call(component_name, options)
        render_options = options.merge(inline: html)
        render(render_options)
      end

      %i[component svelte svelte_component].each do |renderer_name|
        ActionController::Renderers.add renderer_name, &render_component
      end
    end

    rake_tasks do
      load 'svelte/rails/install_task.rake'
    end
  end
end
