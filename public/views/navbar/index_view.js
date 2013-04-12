var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['backbone', 'text!templates/navbar/index.html'], function(Backbone, Template) {
  var IndexView, _ref;

  return IndexView = (function(_super) {
    __extends(IndexView, _super);

    function IndexView() {
      this.render = __bind(this.render, this);      _ref = IndexView.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    IndexView.prototype.className = 'navbar navbar-inverse navbar-fixed-top';

    IndexView.prototype.initialize = function(options) {
      return this.template = _.template(Template);
    };

    IndexView.prototype.render = function() {
      this.$el.html(this.template);
      return this;
    };

    return IndexView;

  })(Backbone.View);
});
