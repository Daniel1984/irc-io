define [
  'views/navbar/index_view'
  'views/login/index_view'
  'views/chat/index_view'
  'backbone'
  'text!templates/site/index.html'
  ], (NavbarView, LoginView, ChatView, Backbone, Template) ->
    
    class PageView extends Backbone.View
      className: 'site'
        
      initialize: (options) ->
        @template = _.template(Template)
        io.on 'let:user:in', @displayVideoChatLayout
        
      render: =>
        @$el.html(@template)
        @renderNavbar()
        @renderLogin()
        @
        
      renderNavbar: =>
        @navbarView = new NavbarView()
        @$el.find('.navbar-wrapper').append(@navbarView.render().el)
      
      renderLogin: =>
        @loginView = new LoginView()
        @$el.append(@loginView.render().el)
        
      displayVideoChatLayout: (data) =>
        @loginView.leave()
        @chatView = new ChatView(user: data)
        @$el.find('.chat').append(@chatView.render().el)