define [
  'views/dashboard/item_view'
  'collections/users'
  'backbone'
  ], (ItemView, Users, Backbone) ->
    
    class ListView extends Backbone.View
      tagName: 'dl'
      className: 'dl-horizontal'
        
      initialize: (options) ->
        super(options)
        @connections = options.connections
        @user = options.user
        @users = new Users()
        @users.reset(@connections)
      
      render: =>
        @$el.html()
        @addAll()
        @
        
      addAll: =>
        @users.each(@addOne)
        
      addOne: (user) =>
        unless @user.get('id') == user.get('id')
          @itemView = new ItemView(model: user, user: @user)
          @$el.append(@itemView.render().el)