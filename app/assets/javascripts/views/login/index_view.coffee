define [
  'backbone'
  'text!templates/login/index.html'
  'button_spinner'
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
        @$el.find('.btn-login').buttonSpinner()
        nickname = @$el.find('.nickname').val()
        io.emit('join:chat', nickname)
        
      leave: =>
        @remove()