define [
  'views/support/composite_view'
  'views/dashboard/list_view'
  'text!templates/dashboard/index.html'
  ], (CompositeView, ListView, Template) ->
    
    class IndexView extends CompositeView
      className: 'dashboard-view'
        
      initialize: (options) ->
        super(options)
        @template = _.template(Template)
        @user = options.user
        io.on('user:joined', @updateUserList)
        io.on('user:left', @updateUserList)
        
      render: =>
        @$el.html(@template(@user.toJSON()))
        @
        
      updateUserList: (data) =>
        @listView?.remove()
        @listView = new ListView(connections: data.connections, user: @user)
        @appendChildInto(@listView, '.online-user-container')