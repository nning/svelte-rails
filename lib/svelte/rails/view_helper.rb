require 'svelte/renderer'

module Svelte::Rails::ViewHelper
  def svelte_component(*args, &block)
    Svelte::Renderer.new.render(*args) { capture &block if block_given? }
  end
end
