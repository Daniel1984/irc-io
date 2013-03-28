fs = require 'fs'
coffee = require 'coffee-script'
express = require 'express'
path = require 'path'

app = express()
http = require('http')
server = http.createServer(app)
io = require('socket.io').listen(server)

appPath = "#{process.cwd()}/app"
connectCoffeeScript = require('connect-coffee-script')
require("#{__dirname}/app-io")(io)

app.configure ->
  app.set 'views', "#{appPath}/views"
  app.set 'view engine', 'jade'
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.static("#{__dirname}/public", {maxAge: 5000})
  app.use(express.logger('dev'))
  app.use(require('connect-less')(
    src: "#{__dirname}/app/assets"
    dst: "#{__dirname}/tmp/cache/less"
    force: true
    compress: true
  ))
  app.use(express.static("#{__dirname}/tmp/cache/less"))
  app.use(app.router)
  
app.configure 'development', ->
  app.use(express.errorHandler())
  app.use connectCoffeeScript
    src: "#{__dirname}/app/assets/javascripts/"
    bare: true
  app.use(express.static("#{__dirname}/app/assets/javascripts"))

require("#{appPath}/routers/app-router")(app)

port = process.env.PORT || 3300
server.listen port, ->
  console.log "Listening on #{port}"

module.exports.app = server