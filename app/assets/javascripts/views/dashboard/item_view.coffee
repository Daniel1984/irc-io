define [
  'backbone'
  'text!templates/dashboard/item_view.html'
  ], (Backbone, Template) ->
      
    class ItemView extends Backbone.View
      className: 'li'
      events:
        'click': 'showPrivateChat'
        
      initialize: (options) ->
        @template = _.template(Template)
        
      render: =>
        @$el.html(@template(@model.toJSON()))
        @
      
      showPrivateChat: (e) =>
        e.preventDefault()
        console.log 'hello', @model.get('nickname')