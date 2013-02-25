define [
  'backbone'
  'text!templates/chat/index.html'
  'text!templates/chat/new_user_join.html'
  'text!templates/chat/user_msg_body.html'
  'text!templates/chat/user_left.html'
  ], (Backbone, Template, UserJoinTmp, UsrMsgTpl, UserLeftTpl) ->
    
    class PageView extends Backbone.View
      className: 'chat-view'
        
      events:
        "keydown .message-input": "sendPublicMessage"
        
      initialize: (options) ->
        @user = options.user
        @template = _.template(Template)
        @userJoinTpl = _.template(UserJoinTmp)
        @usrMsgTpl = _.template(UsrMsgTpl)
        @userLeftTpl = _.template(UserLeftTpl)
        
        io.on 'user:joined', @onUserJoin
        io.on 'user:left', @onUserLeave
        io.on 'public:message', @displayPublicMessage
        
      render: =>
        @$el.html(@template)
        @chat = @$el.find('.message-view')
        @chatField = @$el.find('.message')
        @msgInput = @$el.find('.message-input')
        @
        
      onUserJoin: (data) =>
        @chatField.append(@userJoinTpl(nickname: data.nickname))
          
      onUserLeave: (data) =>
        @chatField.append(@userLeftTpl(data))
          
      displayPublicMessage: (data) =>
        @chatField.append(@usrMsgTpl(data))
        @chat.animate(scrollTop: @chat.prop('scrollHeight'), 0)
        
      sendPublicMessage: (e) =>
        if e.keyCode == 13
          msg = @msgInput.val()
          if msg == '' then msg = '...'
          io.emit('public:message', msg)
          @msgInput.val('')