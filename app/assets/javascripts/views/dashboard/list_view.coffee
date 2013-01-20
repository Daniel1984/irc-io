define [
  'views/dashboard/item_view'
  'collections/users'
  'backbone'
  ], (ItemView, Users, Backbone) ->
    
    class ListView extends Backbone.View
      tagName: 'ul'
        
      initialize: (options) ->
        @data = options.data
        @collection = new Users(@data)
      
      render: =>
        @$el.html()
        @addAll()
        @
        
      addAll: =>
        @collection.each(@addOne)
        
      addOne: (model) =>
        @itemView = new ItemView(model: model)
        @$el.append(@itemView.render().el)