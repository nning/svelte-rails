# Svelte-Rails

[![Gem](https://img.shields.io/gem/v/svelte-rails.svg?style=flat-square)](https://rubygems.org/gems/svelte-rails)
[![npm](https://img.shields.io/npm/v/svelte_ujs_ng.svg?style=flat-square)](https://www.npmjs.com/package/svelte_ujs_ng)
![Build Status](https://img.shields.io/github/workflow/status/nning/svelte-rails/Test%20new%20Rails%20app)

Svelte-Rails integrates [Svelte](https://svelte.dev/) with Ruby on Rails. It has the following features:

* Automatically renders Svelte server-side and client-side
* Supports Webpacker >= 4.2 and Ruby on Rails >= 6

## Usage

Make sure, you have [set-up Webpacker](https://github.com/rails/webpacker#installation) and it's [Svelte integration](https://github.com/rails/webpacker/blob/master/docs/integrations.md#svelte).

For a quick start with a new app, simply run:

    rails new demo --webpack=svelte

Add this line to your application's Gemfile:

```ruby
gem 'svelte-rails'
```

And then execute:

    $ bundle
    $ rails svelte:install

You can overwrite conflicting files if you have started with a fresh Rails app or did not change the webpack config of your existing one.

An example Rails app demonstrating the integration of svelte-rails can be found here:  
https://github.com/nning/svelte-rails-demo

## View Helper

```erb
<%= svelte_component :Hello, name: 'Svelte' %>
<%= svelte_component :Hello, {name: 'Svelte'}, {prerender: true} %>
```

## Controller Renderer

```ruby
class TodoController < ApplicationController
  def index
    @todos = Todo.all
    render component: 'TodoList', props: { todos: @todos }
  end
end
```

`prerender` is activated by default, can be disabled with `prerender: false`.

## Missing Features

* HMR and Bundle consistency (server-rendered HTML is cached and client-side updates on changes to the sources)
* Generator for components
* Render pools
* Better documentation for setup

## Configuration Options

Configuration can be changed in `config/application.rb`, for example.

    # Prerender (SSR) by default (i.e. without passing `prerender:true` to the view helper)
    config.svelte.prerender_default = false

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nning/svelte-rails. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/nning/svelte-rails/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
