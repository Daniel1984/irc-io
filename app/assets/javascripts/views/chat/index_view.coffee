define [
  'backbone'
  'text!templates/chat/index.html'
  ], (Backbone, Template) ->
    
    class PageView extends Backbone.View
      className: 'chat-view'
        
      events:
        "keydown .message-input": "sendPublicMessage"
        
      initialize: (options) ->
        @template = _.template(Template)
        io.on 'new:user:joined', @onNewUserJoin
        io.on 'public:message:from:server', @displayPublicMessage
        
      render: =>
        @$el.html(@template(@user))
        @
        
      onNewUserJoin: (data) =>
        @$el.find('.message-view').append("<p><strong class='nickname-join'>#{data.nickname}:</strong> <strong>just joined the chat!</strong></p>")
          
      displayPublicMessage: (data) =>
        @$el.find('.message-view').append("<p><strong class='nickname-active'>#{data.nickname}:</strong> #{data.message}</p>")
        
      sendPublicMessage: (e) =>
        if e.keyCode == 13
          message = @$el.find('.message-input').val()
          io.emit('public:message:from:user', message)
          @$el.find('.message-input').val('')