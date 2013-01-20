define [
  'backbone'
  'text!templates/chat/index.html'
  'text!templates/chat/new_user_join.html'
  'text!templates/chat/user_msg_body.html'
  'text!templates/chat/user_left.html'
  ], (Backbone, Template, NewUserTmp, UsrMsgTpl, UserLeftTpl) ->
    
    class PageView extends Backbone.View
      className: 'chat-view'
        
      events:
        "keydown .message-input": "sendPublicMessage"
        
      initialize: (options) ->
        @template = _.template(Template)
        @newUserTpl = _.template(NewUserTmp)
        @usrMsgTpl = _.template(UsrMsgTpl)
        @userLeftTpl = _.template(UserLeftTpl)
        
        io.on 'new:user:joined', @onNewUserJoin
        io.on 'user:left:chat', @onUserLeave
        io.on 'public:message:from:server', @displayPublicMessage
        
      render: =>
        @$el.html(@template(@user))
        @
        
      onNewUserJoin: (data) =>
        @$el.find('.message-view').append(@newUserTpl(data))
          
      onUserLeave: (data) =>
        @$el.find('.message-view').append(@userLeftTpl(data))
          
      displayPublicMessage: (data) =>
        @$el.find('.message-view').append(@usrMsgTpl(data))
        
      sendPublicMessage: (e) =>
        if e.keyCode == 13
          message = @$el.find('.message-input').val()
          io.emit('public:message:from:user', message)
          @$el.find('.message-input').val('')