# Svelte-Rails

Svelte-Rails integrates [Svelte](https://svelte.dev/) with Ruby on Rails. It has the following features:

* Automatically renders Svelte server-side and client-side
* Supports Webpacker >= 4.2 and Ruby on Rails >= 6

## Usage

Make sure, you have [set-up Webpacker](https://github.com/rails/webpacker#installation) and it's [Svelte integration](https://github.com/rails/webpacker/blob/master/docs/integrations.md#svelte).

Add this line to your application's Gemfile:

```ruby
gem 'svelte-rails', path: '../svelte-rails'
```

And then execute:

    $ bundle
    $ rails svelte:install

If you have started with a fresh Rails app, you can overwrite conflicting files.

An example Rails app demonstrating the integration of svelte-rails can be found here:  
https://github.com/nning/svelte-rails-demo/commits/master

## View Helper

```erb
<%= svelte_component :Hello, name: 'Svelte' %>
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

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nning/svelte-rails. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/nning/svelte-rails/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
