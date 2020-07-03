require 'rails/railtie'

module Svelte::Rails
  class Railtie < ::Rails::Railtie
    initializer 'react_rails.setup_view_helpers', after: :load_config_initializers, group: :all do |app|
      ActiveSupport.on_load(:action_view) do
        include ::Svelte::Rails::ViewHelper
      end
    end

    rake_tasks do
      load 'svelte/rails/install_task.rake'
    end
  end
end
