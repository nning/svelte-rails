#!/bin/sh

set -xe
export DISABLE_SPRING=true

# nvm use --delete-prefix v14.5.0

rails new svelte-rails-test --webpack=svelte
cd svelte-rails-test

echo "gem 'svelte-rails', path: '..'" >> Gemfile
bundle

yes | rails svelte:install

sed -i 's/svelte_ujs_ng.*$/svelte_ujs_ng": "..",/g' package.json
yarn

# TODO This does not work in shell context, yet
rails g controller greetings show

cat <<EOF > app/views/greetings/show.html.erb
<%= svelte_component :Hello, {name: 'Test'}, {prerender: true} %>
EOF

# rails s -d
# xdg-open http://localhost:3000/greetings/show

# kill `cat tmp/pids/server.pid`

rails db:migrate

cat <<EOF > test/system/features_test.rb
require 'application_system_test_case'

class FeaturesTest < ApplicationSystemTestCase
  test 'SSR from view and update by hydration' do
    visit greetings_show_url

    assert_selector 'h1', text: 'Hello Test! ❤'
    assert !find('code').text.nil?
  end
end
EOF

sed -i 's/driven_by :selenium.*$/driven_by :selenium, using: :headless_chrome/g' test/application_system_test_case.rb

rails test:system
