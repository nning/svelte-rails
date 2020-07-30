const config = require('@rails/webpacker/package/config')
const fs = require('fs')
const path = require('path')
const WebpackBeforeBuildPlugin = require('before-build-webpack')

// https://www.viget.com/articles/run-multiple-webpack-configs-sequentially/
class WaitPlugin extends WebpackBeforeBuildPlugin {
  constructor(file, interval = 200, timeout = 30000) {
    const filePath = path.join(config.outputPath, file)

    try {
      fs.unlinkSync(filePath)
    } catch(e) {
      // Ignore if file does not exist
    }

    super((stats, callback) => {
      let start = Date.now()

      function poll() {
        if (fs.existsSync(filePath)) {
          callback()
        } else if (Date.now() - start > timeout) {
          throw Error(`Waited too long for "${file}" to exist.`)
        } else {
          setTimeout(poll, interval)
        }
      }

      poll()
    })
  }
}

module.exports = WaitPlugin
