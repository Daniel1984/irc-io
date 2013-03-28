var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['backbone'], function(Backbone) {
  var CompositeView;

  return CompositeView = (function(_super) {
    __extends(CompositeView, _super);

    function CompositeView(options) {
      CompositeView.__super__.constructor.call(this, options);
      this.children = _([]);
    }

    CompositeView.prototype.leave = function() {
      this._leaveChildren();
      this._removeFromParent();
      return CompositeView.__super__.leave.call(this);
    };

    CompositeView.prototype.renderChild = function(view) {
      view.parent = this;
      view.render();
      return this.children.push(view);
    };

    CompositeView.prototype.appendChild = function(view) {
      this.renderChild(view);
      return this.$el.append(view.el);
    };

    CompositeView.prototype.prependChild = function(view) {
      this.renderChild(view);
      return this.$el.prepend(view.el);
    };

    CompositeView.prototype.renderChildInto = function(view, container) {
      this.renderChild(view);
      return this.$(container).empty().append(view.el);
    };

    CompositeView.prototype.appendChildInto = function(view, container) {
      this.renderChild(view);
      return this.$(container).append(view.el);
    };

    CompositeView.prototype.appendChildAfter = function(view, container) {
      this.renderChild(view);
      return this.$(container).after(view.el);
    };

    CompositeView.prototype.prependChildInto = function(view, container) {
      this.renderChild(view);
      return this.$(container).prepend(view.el);
    };

    CompositeView.prototype._leaveChildren = function() {
      return this.children.chain().clone().each(function(view) {
        if (view.leave) {
          return view.leave();
        }
      });
    };

    CompositeView.prototype._removeFromParent = function() {
      if (this.parent) {
        return this.parent.removeChild(this);
      }
    };

    CompositeView.prototype.removeChild = function(view) {
      var index;

      index = this.children.indexOf(view);
      return this.children.splice(index, 1);
    };

    return CompositeView;

  })(Backbone.View);
});
