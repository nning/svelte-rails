require 'rails/railtie'

module Svelte::Rails
  class Railtie < ::Rails::Railtie
    initializer 'svelte_rails.setup_view_helpers', after: :load_config_initializers, group: :all do |app|
      ActiveSupport.on_load(:action_view) do
        include ::Svelte::Rails::ViewHelper
      end
    end

    initializer 'svelte_rails.add_component_renderer', group: :all do |app|
      ActionController::Renderers.add :component do |component_name, options|
        renderer = ::Svelte::Rails::ControllerRenderer.new
        html = renderer.call(component_name, options)
        render_options = options.merge(inline: html)
        render(render_options)
      end
    end

    rake_tasks do
      load 'svelte/rails/install_task.rake'
    end
  end
end
