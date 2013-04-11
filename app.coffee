fs = require 'fs'
express = require 'express'
path = require 'path'
lessMiddleware = require 'less-middleware'

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
  app.use(express.logger('dev'))
  app.use lessMiddleware
    dest: "#{__dirname}/public"
    src: "#{__dirname}/app/assets"
    force: true
    compress: true
  app.use(express.static("#{__dirname}/public/"))
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