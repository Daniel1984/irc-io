define [
  'views/support/composite_view'
  'views/navbar/index_view'
  'views/login/index_view'
  'views/video/index_view'
  'views/video/receiver_view'
  'views/chat/index_view'
  'views/dashboard/index_view'
  'models/user'
  'text!templates/site/index.html'
  ], (CompositeView, NavbarView, LoginView, VideoView, ReceiverView,
      ChatView, DashboardView, User, Template) ->
    
    class PageView extends CompositeView
      className: 'site'
        
      initialize: (options) ->
        super(options)
        @template = _.template(Template)
        io.on('grant:user:access', @renderLayout)
        io.on('start:video', @displayVideo)
        io.on('broadcast:video', @displayReceivedVideo)
        @receivers = []
        
      render: =>
        @$el.html(@template)
        @renderNavbar()
        @renderLogin()
        @
        
      renderNavbar: =>
        @navbarView = new NavbarView()
        @appendChildInto(@navbarView, '.navbar-wrapper')
      
      renderLogin: =>
        @loginView = new LoginView()
        @appendChild(@loginView)
        
      renderLayout: (data) =>
        @loginView.leave()
        @user = new User(data)
        @chatView = new ChatView(user: @user)
        @appendChildInto(@chatView, '.chat')
        @dashboardView = new DashboardView(user: @user)
        @appendChildInto(@dashboardView, '.dashboard')
      
      displayVideo: (user_id) =>
        if @videoView? == false
          @videoView = new VideoView(user_id: user_id)
          @appendChildInto(@videoView, '.video')
        else
          @receiver = new ReceiverView(className: user_id)
          @appendChildInto(@receiver, '.video-view-inner')
          @receivers.push(@receiver)
          
      displayReceivedVideo: (data) =>
        for receiver in @receivers
          if receiver.className != data.user_id
            receiver.setSrc(data.image_data)