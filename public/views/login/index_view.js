var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['backbone', 'text!templates/login/index.html', 'button_spinner'], function(Backbone, Template) {
  var IndexView, _ref;

  return IndexView = (function(_super) {
    __extends(IndexView, _super);

    function IndexView() {
      this.leave = __bind(this.leave, this);
      this.join = __bind(this.join, this);
      this.render = __bind(this.render, this);      _ref = IndexView.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    IndexView.prototype.className = 'container';

    IndexView.prototype.events = {
      'submit': 'join'
    };

    IndexView.prototype.initialize = function(options) {
      return this.template = _.template(Template);
    };

    IndexView.prototype.render = function() {
      this.$el.html(this.template);
      return this;
    };

    IndexView.prototype.join = function(e) {
      var nickname;

      e.preventDefault();
      this.$el.find('.btn-login').buttonSpinner();
      nickname = this.$el.find('.nickname').val();
      return io.emit('join:chat', nickname);
    };

    IndexView.prototype.leave = function() {
      return this.remove();
    };

    return IndexView;

  })(Backbone.View);
});
