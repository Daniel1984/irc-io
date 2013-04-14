define [
  'views/support/composite_view'
  'views/video/transmitter_view'
  'views/video/canvas_view'
  'views/video/receiver_view'
  'text!templates/video/index.html'
  ], (CompositeView, TransmitterView, CanvasSFXview, ReceiverView, Template) ->
    class IndexView extends CompositeView
      className: 'video-view'
                
      initialize: (options) ->
        @template = _.template(Template)
        @user_id = options.user_id
        io.on('broadcast:video', @displayVideo)
        
      render: =>
        @$el.html(@template)
        @renderTransmitter()
        @renderSFXcanvas()
        @renderReceiver()
        @
      
      renderSFXcanvas: =>
        @canvasView = new CanvasSFXview()
        @appendChildInto(@canvasView, '.video-view-inner')
      
      renderTransmitter: =>
        @transmitterView = new TransmitterView()
        @appendChildInto(@transmitterView, '.video-view-inner')
              
      renderReceiver: =>
        @receiverView = new ReceiverView()
        @appendChildInto(@receiverView, '.video-view-inner')
              
      startVideoTransmission: =>
        getSnapshotData = @getSnapshotData
        user_id = @user_id
        setInterval ->
          data = { user_id: user_id, image_data: getSnapshotData() }
          io.emit('broadcast:video', data)
        , 250
      
      getSnapshotData: =>
        data = {}
        data.width = @transmitterView.getWidth()
        data.height = @transmitterView.getHeight()
        data.video = @transmitterView.getVideoObj()
        @canvasView.getSnapshot(data)
      
      displayVideo: (data) =>
        @receiverView.setSrc(data.image_data)
                
      leave: =>
        @remove()