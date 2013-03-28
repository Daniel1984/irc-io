define(['jquery', 'underscore', 'backbone', 'views/site/page_view'], function($, _, Backbone, PageView) {
  return {
    init: function() {
      var pageView;

      pageView = new PageView();
      return $('body').append(pageView.render().el);
    }
  };
});
