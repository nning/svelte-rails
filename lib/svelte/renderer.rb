require 'execjs'
require 'action_view'

module Svelte
  class Renderer
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::TextHelper

    attr_accessor :output_buffer

    # This pattern matches the code that initializes the dev-server client.
    CLIENT_REQUIRE = %r{__webpack_require__\(.*webpack-dev-server\/client\/index\.js.*\n}

    def render(name, props = {}, options = {}, &block)
      prerender_options = options[:prerender]
      if prerender_options
        block = Proc.new { concat(prerender_component(name, props, prerender_options)) }
      end

      html_options = options.reverse_merge(:data => {})
      unless prerender_options == :static
        html_options[:data].tap do |data|
          data[:svelte_class] = name
          data[:svelte_props] = props.is_a?(String) ? props : props.to_json
          data[:hydrate] = 't' if prerender_options
        end
      end

      html_options.except!(:tag, :prerender, :camelize_props)

      content_tag(options[:tag] || :div, '', html_options, &block)
    end

    private

    def prerender_component(component_name, props, prerender_options)
      initial_code = <<-JS
        var global = global || this;
        var self = self || this;

        #{find_asset('server_rendering.js')}
      JS

      # File.write(::Rails.root.join('debug.js'), initial_code)
      @context = ExecJS.compile(initial_code)

      js_code = <<-JS
        (function(){
          return SvelteRailsUJS.serverRender('#{component_name}', #{props.to_json});
        })()
      JS

      @context.eval(js_code).html_safe
    end

    def find_asset(logical_path)
      if Webpacker.dev_server.running?
        ds = Webpacker.dev_server

        asset_path = Webpacker.manifest.lookup(logical_path).to_s
        # Remove the protocol and host from the asset path. Sometimes webpacker includes this, sometimes it does not
        asset_path.slice!("#{ds.protocol}://#{ds.host_with_port}")

        require 'open-uri'

        dev_server_asset = URI.send(:open, "#{ds.protocol}://#{ds.host_with_port}#{asset_path}").read
        dev_server_asset.sub!(CLIENT_REQUIRE, '//\0')
        dev_server_asset
      else
        File.read(::Rails.root.join('public', Webpacker.manifest.lookup(logical_path)[1..-1]))
      end
    end
  end
end
