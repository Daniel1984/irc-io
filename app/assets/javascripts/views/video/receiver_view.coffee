define [
  'backbone'
  ], (Backbone) ->
    class ReceiverView extends Backbone.View
      tagName: 'img'
      
      initialize: (options) ->
        super(options)
        
      render: =>
        @$el.html()
        @
        
      setSrc: (data) =>
        @$el.attr(src: data)