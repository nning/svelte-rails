#!/bin/sh

set -e

nvm use --delete-prefix v14.5.0

rails new svelte-rails-test --webpack=svelte
cd svelte-rails-test

echo "gem 'svelte-rails', path: '../svelte-rails'" >> Gemfile
bundle

yes | rails svelte:install

sed -i 's/svelte_ujs_ng.*$/svelte_ujs_ng": "..\/svelte-rails",/g' package.json
yarn

# TODO This does not work in shell context, yet
rails g controller greetings show

cat <<EOF > app/views/greetings/show.html.erb
<%= svelte_component :Hello, {name: 'Test'}, {prerender: true} %>
EOF

rails s -d

xdg-open http://localhost:3000/greetings/show

kill `cat tmp/pids/server.pid`
