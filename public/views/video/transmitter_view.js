var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['backbone'], function(Backbone) {
  var TransmitterView, _ref;

  return TransmitterView = (function(_super) {
    __extends(TransmitterView, _super);

    function TransmitterView() {
      this.getHeight = __bind(this.getHeight, this);
      this.getWidth = __bind(this.getWidth, this);
      this.getVideoObj = __bind(this.getVideoObj, this);
      this.onError = __bind(this.onError, this);
      this.startVideoTranslation = __bind(this.startVideoTranslation, this);
      this.render = __bind(this.render, this);      _ref = TransmitterView.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    TransmitterView.prototype.tagName = 'video';

    TransmitterView.prototype.initialize = function(options) {
      return TransmitterView.__super__.initialize.call(this, options);
    };

    TransmitterView.prototype.render = function() {
      this.$el.html();
      this.video = this.$el[0];
      this.$el.attr('autoplay', true);
      this.startVideoTranslation();
      return this;
    };

    TransmitterView.prototype.startVideoTranslation = function() {
      var video;

      video = this.video;
      navigator.getUserMedia({
        video: true
      }, function(stream) {
        return video.src = window.URL.createObjectURL(stream);
      }, this.onError);
      return this.parent.startVideoTransmission();
    };

    TransmitterView.prototype.onError = function() {
      return alert('Ups! Something is wrong. Why not to try and refresh the page?');
    };

    TransmitterView.prototype.getVideoObj = function() {
      return this.video;
    };

    TransmitterView.prototype.getWidth = function() {
      return this.$el.width();
    };

    TransmitterView.prototype.getHeight = function() {
      return this.$el.height();
    };

    return TransmitterView;

  })(Backbone.View);
});
