define [
  'backbone'
  'text!templates/login/index.html'
  ], (Backbone, Template) ->
    
    class IndexView extends Backbone.View
      className: 'container'
      events:
        "submit": "join"
        
      initialize: (options) ->
        @template = _.template(Template)
        io.on 'talk', @onTalk
        
      render: =>
        @$el.html(@template)
        @
        
      join: (e) =>
        e.preventDefault()
        io.emit('ready')
        
      onTalk: (data) =>
        console.log data.message