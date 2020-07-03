module.exports = {
  test: /\.svelte$/,
  use: [{
    loader: 'svelte-loader',
    options: {
      hotReload: true,
      hydratable: true
    }
  }],
}
