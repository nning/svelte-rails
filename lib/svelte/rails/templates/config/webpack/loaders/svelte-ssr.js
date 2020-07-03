module.exports = {
  test: /\.svelte$/,
  use: [{
    loader: 'svelte-loader',
    options: {
      generate: 'ssr',
      emitCss: false,
      css: false
    }
  }],
}
