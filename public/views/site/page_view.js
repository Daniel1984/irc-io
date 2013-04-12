var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['views/support/composite_view', 'views/navbar/index_view', 'views/login/index_view', 'views/video/index_view', 'views/video/receiver_view', 'views/chat/index_view', 'views/dashboard/index_view', 'models/user', 'text!templates/site/index.html'], function(CompositeView, NavbarView, LoginView, VideoView, ReceiverView, ChatView, DashboardView, User, Template) {
  var PageView, _ref;

  return PageView = (function(_super) {
    __extends(PageView, _super);

    function PageView() {
      this.displayReceivedVideo = __bind(this.displayReceivedVideo, this);
      this.displayVideo = __bind(this.displayVideo, this);
      this.renderLayout = __bind(this.renderLayout, this);
      this.renderLogin = __bind(this.renderLogin, this);
      this.renderNavbar = __bind(this.renderNavbar, this);
      this.render = __bind(this.render, this);      _ref = PageView.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    PageView.prototype.className = 'site';

    PageView.prototype.initialize = function(options) {
      PageView.__super__.initialize.call(this, options);
      this.template = _.template(Template);
      io.on('grant:user:access', this.renderLayout);
      io.on('start:video', this.displayVideo);
      io.on('broadcast:video', this.displayReceivedVideo);
      return this.receivers = [];
    };

    PageView.prototype.render = function() {
      this.$el.html(this.template);
      this.renderNavbar();
      this.renderLogin();
      return this;
    };

    PageView.prototype.renderNavbar = function() {
      this.navbarView = new NavbarView();
      return this.appendChildInto(this.navbarView, '.navbar-wrapper');
    };

    PageView.prototype.renderLogin = function() {
      this.loginView = new LoginView();
      return this.appendChild(this.loginView);
    };

    PageView.prototype.renderLayout = function(data) {
      this.loginView.leave();
      this.user = new User(data);
      this.chatView = new ChatView({
        user: this.user
      });
      this.appendChildInto(this.chatView, '.chat');
      this.dashboardView = new DashboardView({
        user: this.user
      });
      return this.appendChildInto(this.dashboardView, '.dashboard');
    };

    PageView.prototype.displayVideo = function(user_id) {
      if ((this.videoView != null) === false) {
        this.videoView = new VideoView({
          user_id: user_id
        });
        return this.appendChildInto(this.videoView, '.video');
      } else {
        this.receiver = new ReceiverView({
          className: user_id
        });
        this.appendChildInto(this.receiver, '.video-view-inner');
        return this.receivers.push(this.receiver);
      }
    };

    PageView.prototype.displayReceivedVideo = function(data) {
      var receiver, _i, _len, _ref1, _results;

      _ref1 = this.receivers;
      _results = [];
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        receiver = _ref1[_i];
        if (receiver.className !== data.user_id) {
          _results.push(receiver.setSrc(data.image_data));
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };

    return PageView;

  })(CompositeView);
});
