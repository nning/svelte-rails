require 'rails/generators'


module Svelte
  class InstallGenerator < ::Rails::Generators::Base
    TEMPLATE_DIR = File.expand_path('../templates', __FILE__)
    source_root TEMPLATE_DIR

    desc 'Install Svelte support'

    def create_directories
      empty_directory components_dir
      create_file File.join(components_dir, '.keep')
    end

    def copy_templates
      copy_template(webpack_dir, 'environment.js')
      copy_template(webpack_dir, 'development.js')
      copy_template(webpack_dir, 'production.js')
      copy_template(webpack_dir, 'test.js')

      copy_template(webpack_dir, 'loaders', 'svelte.js')
      copy_template(webpack_dir, 'loaders', 'svelte-ssr.js')

      copy_template(packs_dir, 'server_rendering.js')
      copy_template(components_dir, 'Hello.svelte')
    end

    def update_application_entry
      path = Pathname.new('app/javascript/packs/application.js')
      content = File.read(File.join(TEMPLATE_DIR, path))

      if path.exist?
        append_file(path, content)
      else
        create_file(path, content)
      end
    end

    def install_svelte_ujs
      `yarn add svelte_ujs_ng svelte-preprocess`
    end

    private

    def rails_dir
      Pathname.new(destination_root).relative_path_from(::Rails.root)
    end

    def packs_dir
      Webpacker.config.source_entry_path.relative_path_from(::Rails.root)
    end

    def js_dir
      packs_dir.parent
    end

    def components_dir
      File.join(js_dir, 'components')
    end

    def webpack_dir
      File.join(rails_dir, 'config', 'webpack')
    end

    def copy_template(*path_segments)
      source = File.join(*path_segments)
      template(source, ::Rails.root.join(source))
    end
  end
end
