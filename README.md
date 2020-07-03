# Svelte-Rails

Svelte-Rails integrates [Svelte](https://svelte.dev/) with Ruby on Rails. It has the following features:

* Automatically renders Svelte server-side and client-side
* Supports Webpacker >= 4.2 and Ruby on Rails >= 6

## Usage

Make sure, you have [set-up Webpacker](https://github.com/rails/webpacker#installation) and it's [Svelte integration](https://github.com/rails/webpacker/blob/master/docs/integrations.md#svelte).

Add this line to your application's Gemfile:

```ruby
gem 'svelte-rails'
```

And then execute:

    $ bundle install
    $ rails generate svelte:install

An example Rails app with svelte-rails can be seen here:  
https://github.com/nning/rails-svelte-poc

## View Helper

```erb
<%= svelte_component(:Hello, name: 'Svelte') %>
```

## Missing Features

* Better documentation for setup
* Turbolinks integration
* Rails generator for initial setup (the previously mentioned line does not work, yet)
* HMR and Bundle consistency (server-rendered HTML is cached and client-side updates on changes to the sources)
* Render components directly from controllers
* Generator for components
* Render pools

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nning/svelte-rails. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/nning/svelte-rails/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
