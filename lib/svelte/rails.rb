require 'svelte/rails/version'

module Svelte
  module Rails
    # class Error < StandardError; end
  end
end

require 'svelte/rails/view_helper'
require 'svelte/rails/railtie' if defined?(Rails)
