fs = require 'fs'
coffee = require 'coffee-script'
express = require 'express'
path = require 'path'

app = express()
http = require('http')
server = http.createServer(app)
io = require('socket.io').listen(server)

appPath = "#{process.cwd()}/app"

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
  app.get(/.js$/, (req, res, next) ->
    script = req.originalUrl.substring(1, req.originalUrl.length - 3)
    try
      file = "app/assets/javascripts/#{script}.coffee"
      cs = fs.readFileSync "#{__dirname}/#{file}", "ascii"
      try 
        js = coffee.compile cs 
        res.header 'Content-Type', 'application/x-javascript'
        res.send(js, 200)
      catch e
        res.send("Coffee compile error in #{file}\n" + e.stack, { 'Content-Type': 'text/plain' }, 500)
    catch e
      next()
  )
  app.use(express.static("#{__dirname}/app/assets/javascripts"))

require("#{appPath}/routers/app-router")(app)

port = process.env.PORT || 3300
server.listen port, ->
  console.log "Listening on #{port}"

module.exports.app = server