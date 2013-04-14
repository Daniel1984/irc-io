var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['backbone'], function(Backbone) {
  var CanvasView, _ref;

  return CanvasView = (function(_super) {
    __extends(CanvasView, _super);

    function CanvasView() {
      this.getSnapshot = __bind(this.getSnapshot, this);
      this.render = __bind(this.render, this);      _ref = CanvasView.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    CanvasView.prototype.tagName = 'canvas';

    CanvasView.prototype.initialize = function(options) {
      return CanvasView.__super__.initialize.call(this, options);
    };

    CanvasView.prototype.render = function() {
      this.$el.html();
      this.$el.attr({
        width: 200
      });
      this.$el.attr({
        height: 150
      });
      this.$el.css({
        display: "none"
      });
      this.canvas = this.$el[0];
      this.ctx = this.canvas.getContext('2d');
      return this;
    };

    CanvasView.prototype.getSnapshot = function(data) {
      this.ctx.drawImage(data.video, 0, 0, data.width, data.height);
      return this.canvas.toDataURL('image/webp');
    };

    return CanvasView;

  })(Backbone.View);
});
