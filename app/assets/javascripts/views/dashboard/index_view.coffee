define [
  'views/support/composite_view'
  'views/dashboard/list_view'
  'text!templates/dashboard/index.html'
  ], (CompositeView, ListView, Template) ->
    
    class IndexView extends CompositeView
      className: 'dashboard-view'
        
      initialize: (options) ->
        super(options)
        @user = options.user
        io.on('user:joined', @updateUserList)
        io.on('user:left', @updateUserList)
        
      render: =>
        @template = _.template(Template)
        @$el.html(@template)
        @
        
      updateUserList: (data) =>
        @listView?.remove()
        @listView = new ListView(connections: data.connections, user: @user)
        @appendChildInto(@listView, '.online-user-container')