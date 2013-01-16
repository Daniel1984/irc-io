fs = require 'fs'
coffee = require 'coffee-script'
express = require "express"
app = require('express.io')()
path = require "path"
app.http().io()

appPath = "#{process.cwd()}/app"

app.configure () ->
  app.set("transports", ["xhr-polling"])
  app.set("polling duration", 10)
  app.set 'views', "#{appPath}/views"
  app.set 'view engine', 'jade'
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.static("#{__dirname}/public", {maxAge: 5000})
  app.use(express.favicon())
  app.use(express.logger('dev'))
  # app.use(require('less-middleware')({ src: __dirname + '/public' }))
  app.use(require('connect-less')(
    src: "#{__dirname}/app/assets"
    dst: "#{__dirname}/tmp/cache/less"
    force: true
    compress: true
  ))
  app.use(express.static("#{__dirname}/tmp/cache/less"))
  app.use(app.router)


app.io.on 'connection', (socket) ->
  console.log 'conected'
  
app.configure 'development', () ->
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
require("#{appPath}/routers/io-router")(app)

port = process.env.PORT || 3300
app.listen port, ->
  console.log "Listening on #{port}"

module.exports.app = app