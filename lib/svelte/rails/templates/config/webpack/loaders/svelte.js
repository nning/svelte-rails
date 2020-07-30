const sveltePreprocess = require('svelte-preprocess')

const dev = process.env.RAILS_ENV !== 'production'

module.exports = {
  test: /\.svelte$/,
  use: [
    {
      loader: 'babel-loader',
      options: {
        presets: ['@babel/preset-env'],
      }
    },
    {
      loader: 'svelte-loader',
      options: {
        dev,
        hotReload: true,
        hydratable: true,
        emitCss: true,
        preprocess: sveltePreprocess()
      }
    }
  ],
}
