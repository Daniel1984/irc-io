define [
  'backbone'
  'views/navbar/index_view'
  'views/login/index_view'
  ], (Backbone, NavbarView, LoginView) ->
    
    class PageView extends Backbone.View
      
      initialize: (options) ->
        
      render: =>
        @$el.html()
        @renderNavbar()
        @renderLogin()
        @
        
      renderNavbar: =>
        @navbarView = new NavbarView()
        @$el.append(@navbarView.render().el)
      
      renderLogin: =>
        @loginView = new LoginView()
        @$el.append(@loginView.render().el)