appPath = "#{process.cwd()}/app"

homeCtrl = require "#{appPath}/controllers/home"

module.exports = (app) ->
  app.get "/", homeCtrl.index