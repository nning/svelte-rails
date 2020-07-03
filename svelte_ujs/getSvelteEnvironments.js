const config = require('@rails/webpacker/package/config')
const ConfigList = require('@rails/webpacker/package/config_types/config_list')
const WaitPlugin = require('svelte_ujs/WaitPlugin')

// Use version of WebpackAssetsManifest that supports merging entrypoints in manifest.json
// https://github.com/webdeveric/webpack-assets-manifest/pull/59
const WebpackAssetsManifest = require('webpack-assets-manifest')

const env = process.env.NODE_ENV
const Environment = require('@rails/webpacker/package/environments/' + env)

function getSvelteEnvironments(clientLoader, serverLoader) {
  const clientEnvironment = new Environment()
  clientEnvironment.entry.delete('server_rendering')
  clientEnvironment.loaders.prepend('svelte', clientLoader)

  // We need to set merge:true for generating the manifest.json
  clientEnvironment.plugins.delete('Manifest')
  clientEnvironment.plugins.append(
    'Manifest',
    new WebpackAssetsManifest({
      entrypoints: true,
      writeToDisk: true,
      publicPath: config.publicPathWithoutCDN,
      merge: true
    })
  )

  const serverEnvironment = new Environment()
  // TODO Actually delete everything but server_rendering
  serverEnvironment.entry.delete('application')
  serverEnvironment.loaders.prepend('svelte', serverLoader)

  // We need to set merge:true for generating the manifest.json
  serverEnvironment.plugins.delete('Manifest')
  serverEnvironment.plugins.append(
    'Manifest',
    new WebpackAssetsManifest({
      entrypoints: true,
      writeToDisk: true,
      publicPath: config.publicPathWithoutCDN,
      merge: true
    })
  )

  // Wait for the manifest.json created by clientEnvironment
  serverEnvironment.plugins.prepend(
    'WaitPlugin',
    new WaitPlugin('manifest.json')
  )

  return [
    clientEnvironment,
    serverEnvironment
  ]
}

module.exports = getSvelteEnvironments
