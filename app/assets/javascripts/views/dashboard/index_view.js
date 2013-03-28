var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['views/support/composite_view', 'views/dashboard/list_view', 'text!templates/dashboard/index.html'], function(CompositeView, ListView, Template) {
  var IndexView, _ref;

  return IndexView = (function(_super) {
    __extends(IndexView, _super);

    function IndexView() {
      this.updateUserList = __bind(this.updateUserList, this);
      this.render = __bind(this.render, this);      _ref = IndexView.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    IndexView.prototype.className = 'dashboard-view';

    IndexView.prototype.initialize = function(options) {
      IndexView.__super__.initialize.call(this, options);
      this.template = _.template(Template);
      this.user = options.user;
      io.on('user:joined', this.updateUserList);
      return io.on('user:left', this.updateUserList);
    };

    IndexView.prototype.render = function() {
      this.$el.html(this.template(this.user.toJSON()));
      return this;
    };

    IndexView.prototype.updateUserList = function(data) {
      var _ref1;

      if ((_ref1 = this.listView) != null) {
        _ref1.remove();
      }
      this.listView = new ListView({
        connections: data.connections,
        user: this.user
      });
      return this.appendChildInto(this.listView, '.online-user-container');
    };

    return IndexView;

  })(CompositeView);
});
