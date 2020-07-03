require 'svelte/rails/install_generator'

namespace :svelte do
  desc 'Install Svelte support'
  task :install do
    Svelte::InstallGenerator.start
  end
end
