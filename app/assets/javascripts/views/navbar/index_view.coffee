define [
  'backbone'
  'text!templates/navbar/index.html'
  ], (Backbone, Template) ->
    
    class IndexView extends Backbone.View
      className: 'container'
      
      initialize: (options) ->
        @template = _.template(Template)
        
      render: =>
        @$el.html(@template)
        @