appPath = "#{process.cwd()}/app"

# homeCtrl = require "#{appPath}/controllers/home"

module.exports = (app) ->
  app.io.route 'ready', (req) ->
    req.io.emit 'talk',
      message: 'io event from an io route on the server'
  