var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['backbone', 'text!templates/dashboard/item_view.html'], function(Backbone, Template) {
  var ItemView, _ref;

  return ItemView = (function(_super) {
    __extends(ItemView, _super);

    function ItemView() {
      this.showPrivateVideo = __bind(this.showPrivateVideo, this);
      this.showPrivateChat = __bind(this.showPrivateChat, this);
      this.render = __bind(this.render, this);      _ref = ItemView.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    ItemView.prototype.events = {
      'click .chat-btn': 'showPrivateChat',
      'click .video-call-btn': 'showPrivateVideo'
    };

    ItemView.prototype.initialize = function(options) {
      return this.template = _.template(Template);
    };

    ItemView.prototype.render = function() {
      this.$el.html(this.template(this.model.toJSON()));
      return this;
    };

    ItemView.prototype.showPrivateChat = function(e) {
      e.preventDefault();
      return console.log("to develop");
    };

    ItemView.prototype.showPrivateVideo = function(e) {
      e.preventDefault();
      return io.emit('start:video', this.model.get('id'));
    };

    return ItemView;

  })(Backbone.View);
});
