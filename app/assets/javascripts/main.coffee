require.config
  paths: 
    jquery: 'lib/jquery'
    underscore: 'lib/underscore'
    backbone: 'lib/backbone'
    bootstrap: 'lib/bootstrap'
    text: 'lib/require/text'
    domready: 'lib/require/domready'
    spinner: 'lib/spiner'
  shim:
    underscore:
      exports: '_'
    backbone:
      deps: ['jquery', 'underscore']
      exports: "Backbone"
    spin:
      exports: "Spinner"
    bootstrap:
      deps: ['jquery']

require [
  'domready'
  'app'
], (domReady, App) ->
  domReady () ->
    App.init()