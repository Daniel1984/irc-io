define [
  'jquery'
  'underscore'
  'backbone'
  'views/site/page_view'
  'bootstrap'
  ], ($, _, Backbone, PageView) ->
    init: ->
      pageView = new PageView()
      $('body').append(pageView.render().el)

