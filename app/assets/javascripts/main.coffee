require.config
  paths: 
    jquery: 'lib/jquery'
    underscore: 'lib/underscore'
    backbone: 'lib/backbone'
    text: 'lib/require/text'
    domready: 'lib/require/domready'
    spinner: 'lib/spiner'
    button_spinner : 'helpers/button_spinner'
  shim:
    underscore:
      exports: '_'
    backbone:
      deps: ['jquery', 'underscore']
      exports: "Backbone"
    button_spinner : ['jquery','spinner']
    spinner:
      exports: 'Spinner'

require [
  'domready'
  'app'
], (domReady, App) ->
  domReady () ->
    App.init()