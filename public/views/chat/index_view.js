var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['backbone', 'text!templates/chat/index.html', 'text!templates/chat/new_user_join.html', 'text!templates/chat/user_msg_body.html', 'text!templates/chat/user_left.html'], function(Backbone, Template, UserJoinTmp, UsrMsgTpl, UserLeftTpl) {
  var PageView, _ref;

  return PageView = (function(_super) {
    __extends(PageView, _super);

    function PageView() {
      this.sendPublicMessage = __bind(this.sendPublicMessage, this);
      this.displayPublicMessage = __bind(this.displayPublicMessage, this);
      this.onUserLeave = __bind(this.onUserLeave, this);
      this.onUserJoin = __bind(this.onUserJoin, this);
      this.render = __bind(this.render, this);      _ref = PageView.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    PageView.prototype.className = 'chat-view';

    PageView.prototype.events = {
      "keydown .message-input": "sendPublicMessage"
    };

    PageView.prototype.initialize = function(options) {
      this.user = options.user;
      this.template = _.template(Template);
      this.userJoinTpl = _.template(UserJoinTmp);
      this.usrMsgTpl = _.template(UsrMsgTpl);
      this.userLeftTpl = _.template(UserLeftTpl);
      io.on('user:joined', this.onUserJoin);
      io.on('user:left', this.onUserLeave);
      return io.on('public:message', this.displayPublicMessage);
    };

    PageView.prototype.render = function() {
      this.$el.html(this.template);
      this.chat = this.$el.find('.message-view');
      this.chatField = this.$el.find('.message');
      this.msgInput = this.$el.find('.message-input');
      return this;
    };

    PageView.prototype.onUserJoin = function(data) {
      return this.chatField.append(this.userJoinTpl({
        nickname: data.nickname
      }));
    };

    PageView.prototype.onUserLeave = function(data) {
      return this.chatField.append(this.userLeftTpl(data));
    };

    PageView.prototype.displayPublicMessage = function(data) {
      this.chatField.append(this.usrMsgTpl(data));
      return this.chat.animate({
        scrollTop: this.chat.prop('scrollHeight')
      }, 0);
    };

    PageView.prototype.sendPublicMessage = function(e) {
      var msg;

      if (e.keyCode === 13) {
        msg = this.msgInput.val();
        if (msg === '') {
          msg = '...';
        }
        io.emit('public:message', msg);
        return this.msgInput.val('');
      }
    };

    return PageView;

  })(Backbone.View);
});
