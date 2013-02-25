define [
  'backbone'
  'text!templates/dashboard/item_view.html'
  ], (Backbone, Template) ->
      
    class ItemView extends Backbone.View
      events:
        'click .chat-btn': 'showPrivateChat'
        'click .video-call-btn': 'showPrivateVideo'
        
      initialize: (options) ->
        @template = _.template(Template)
        @user = options.user
        
      render: =>
        @$el.html(@template(@model.toJSON()))
        @
      
      showPrivateChat: (e) =>
        e.preventDefault()
        console.log "to develop"
        
      showPrivateVideo: (e) =>
        e.preventDefault()
        io.emit('start:video', @model.get('id'))