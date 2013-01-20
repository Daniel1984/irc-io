define [
  'backbone'
  'text!templates/login/index.html'
  ], (Backbone, Template) ->
    
    class IndexView extends Backbone.View
      className: 'container'
      events:
        'submit': 'join'
        
      initialize: (options) ->
        @template = _.template(Template)
        
      render: =>
        @$el.html(@template)
        @
        
      join: (e) =>
        e.preventDefault()
        nickname = @$el.find('.nickname').val()
        io.emit('join:chat', nickname)
        
      leave: =>
        @remove()