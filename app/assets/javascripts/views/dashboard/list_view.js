var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['views/dashboard/item_view', 'collections/users', 'backbone'], function(ItemView, Users, Backbone) {
  var ListView, _ref;

  return ListView = (function(_super) {
    __extends(ListView, _super);

    function ListView() {
      this.addOne = __bind(this.addOne, this);
      this.addAll = __bind(this.addAll, this);
      this.render = __bind(this.render, this);      _ref = ListView.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    ListView.prototype.tagName = 'dl';

    ListView.prototype.className = 'dl-horizontal';

    ListView.prototype.initialize = function(options) {
      ListView.__super__.initialize.call(this, options);
      this.connections = options.connections;
      this.user = options.user;
      this.users = new Users();
      return this.users.reset(this.connections);
    };

    ListView.prototype.render = function() {
      this.$el.html();
      this.addAll();
      return this;
    };

    ListView.prototype.addAll = function() {
      return this.users.each(this.addOne);
    };

    ListView.prototype.addOne = function(user) {
      if (this.user.get('id') !== user.get('id')) {
        this.itemView = new ItemView({
          model: user
        });
        return this.$el.append(this.itemView.render().el);
      }
    };

    return ListView;

  })(Backbone.View);
});
