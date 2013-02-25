define [
  'backbone'
  ], (Backbone) ->
    class CanvasView extends Backbone.View
      tagName: 'canvas'
      
      initialize: (options) ->
        super(options)
        
      render: =>
        @$el.html()
        @$el.attr(width: 320)
        @$el.attr(height: 240)
        @$el.css(display: "none")
        @canvas = @$el[0]
        @ctx = @canvas.getContext('2d')
        @
        
      getSnapshot: (data) =>
        @ctx.drawImage(data.video, 0, 0, data.width, data.height)
        @canvas.toDataURL('image/webp')