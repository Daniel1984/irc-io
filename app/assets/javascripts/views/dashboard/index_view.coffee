define [
  'views/dashboard/list_view'
  'backbone'
  'text!templates/dashboard/index.html'
  ], (ListView, Backbone, Template) ->
    
    class IndexView extends Backbone.View
      className: 'dashboard-view'
        
      initialize: (options) ->
        @template = _.template(Template)
        io.on 'user:list:update', @updateUserList
        
      render: =>
        @$el.html(@template)
        @
        
      updateUserList: (data) =>
        @listView?.remove()
        @listView = new ListView(data: data)
        @$el.find('.online-user-container').append(@listView.render().el)