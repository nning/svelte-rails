require_relative 'lib/svelte/rails/version'

Gem::Specification.new do |spec|
  spec.name          = 'svelte-rails'
  spec.version       = Svelte::Rails::VERSION
  spec.authors       = ['henning mueller']
  spec.email         = ['mail@nning.io']

  spec.summary       = 'Svelte integration for Ruby on Rails'
  spec.description   = 'Render Svelte components in Rails views. Supports server-side rendering with ExecJS.'
  spec.homepage      = 'https://github.com/nning/svelte-rails'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = spec.homepage + '/blob/master/CHANGELOG.md'

  # spec.add_dependency 'connection_pool'
  spec.add_dependency 'execjs'
  spec.add_dependency 'railties', '>= 5.2'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
