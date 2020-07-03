const clientLoader = require('./loaders/svelte')
const serverLoader = require('./loaders/svelte-ssr')

const getSvelteEnvironments = require('svelte_ujs/getSvelteEnvironments')

module.exports = getSvelteEnvironments(clientLoader, serverLoader)
