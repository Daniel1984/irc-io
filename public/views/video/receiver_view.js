var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['backbone'], function(Backbone) {
  var ReceiverView, _ref;

  return ReceiverView = (function(_super) {
    __extends(ReceiverView, _super);

    function ReceiverView() {
      this.setSrc = __bind(this.setSrc, this);
      this.render = __bind(this.render, this);      _ref = ReceiverView.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    ReceiverView.prototype.tagName = 'img';

    ReceiverView.prototype.initialize = function(options) {
      return ReceiverView.__super__.initialize.call(this, options);
    };

    ReceiverView.prototype.render = function() {
      this.$el.html();
      return this;
    };

    ReceiverView.prototype.setSrc = function(data) {
      return this.$el.attr({
        src: data
      });
    };

    return ReceiverView;

  })(Backbone.View);
});
