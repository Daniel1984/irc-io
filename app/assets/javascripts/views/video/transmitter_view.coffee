define [
  'backbone'
  ], (Backbone) ->
    class TransmitterView extends Backbone.View
      tagName: 'video'
      
      initialize: (options) ->
        super(options)
        
      render: =>
        @$el.html()
        @video = @$el[0]
        @$el.attr('autoplay', true)
        @startVideoTranslation()
        @
        
      startVideoTranslation: =>
        video = @video
        navigator.getUserMedia(video: true, (stream) ->
          video.src = window.URL.createObjectURL(stream)
        , @onError)
        @parent.startVideoTransmission()
      
      onError: =>
        alert 'Ups! Something is wrong. Why not to try and refresh the page?'
        
      getVideoObj: =>
        @video
        
      getWidth: =>
        @$el.width()
        
      getHeight: =>
        @$el.height()