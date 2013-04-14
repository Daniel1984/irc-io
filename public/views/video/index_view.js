var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['views/support/composite_view', 'views/video/transmitter_view', 'views/video/canvas_view', 'views/video/receiver_view', 'text!templates/video/index.html'], function(CompositeView, TransmitterView, CanvasSFXview, ReceiverView, Template) {
  var IndexView, _ref;

  return IndexView = (function(_super) {
    __extends(IndexView, _super);

    function IndexView() {
      this.leave = __bind(this.leave, this);
      this.displayVideo = __bind(this.displayVideo, this);
      this.getSnapshotData = __bind(this.getSnapshotData, this);
      this.startVideoTransmission = __bind(this.startVideoTransmission, this);
      this.renderReceiver = __bind(this.renderReceiver, this);
      this.renderTransmitter = __bind(this.renderTransmitter, this);
      this.renderSFXcanvas = __bind(this.renderSFXcanvas, this);
      this.render = __bind(this.render, this);      _ref = IndexView.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    IndexView.prototype.className = 'video-view';

    IndexView.prototype.initialize = function(options) {
      this.template = _.template(Template);
      this.user_id = options.user_id;
      return io.on('broadcast:video', this.displayVideo);
    };

    IndexView.prototype.render = function() {
      this.$el.html(this.template);
      this.renderTransmitter();
      this.renderSFXcanvas();
      this.renderReceiver();
      return this;
    };

    IndexView.prototype.renderSFXcanvas = function() {
      this.canvasView = new CanvasSFXview();
      return this.appendChildInto(this.canvasView, '.video-view-inner');
    };

    IndexView.prototype.renderTransmitter = function() {
      this.transmitterView = new TransmitterView();
      return this.appendChildInto(this.transmitterView, '.video-view-inner');
    };

    IndexView.prototype.renderReceiver = function() {
      this.receiverView = new ReceiverView();
      return this.appendChildInto(this.receiverView, '.video-view-inner');
    };

    IndexView.prototype.startVideoTransmission = function() {
      var getSnapshotData, user_id;

      getSnapshotData = this.getSnapshotData;
      user_id = this.user_id;
      return setInterval(function() {
        var data;

        data = {
          user_id: user_id,
          image_data: getSnapshotData()
        };
        return io.emit('broadcast:video', data);
      }, 250);
    };

    IndexView.prototype.getSnapshotData = function() {
      var data;

      data = {};
      data.width = this.transmitterView.getWidth();
      data.height = this.transmitterView.getHeight();
      data.video = this.transmitterView.getVideoObj();
      return this.canvasView.getSnapshot(data);
    };

    IndexView.prototype.displayVideo = function(data) {
      return this.receiverView.setSrc(data.image_data);
    };

    IndexView.prototype.leave = function() {
      return this.remove();
    };

    return IndexView;

  })(CompositeView);
});
