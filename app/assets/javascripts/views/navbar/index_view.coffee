define [
  'backbone'
  'text!templates/navbar/index.html'
  ], (Backbone, Template) ->
    
    class IndexView extends Backbone.View
      className: 'navbar navbar-inverse navbar-fixed-top'
      
      initialize: (options) ->
        @template = _.template(Template)
        
      render: =>
        @$el.html(@template)
        @