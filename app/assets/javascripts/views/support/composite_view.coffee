define [
  'backbone'
], (Backbone) ->
  class CompositeView extends Backbone.View
  
    constructor: (options) ->
      super(options)
      @children = _([])
      
    leave: ->
      @_leaveChildren()
      @_removeFromParent()
      super()

    renderChild: (view) ->
      view.parent = @
      view.render()
      @children.push(view)
   
    appendChild: (view) ->
      @renderChild(view)
      @$el.append(view.el)
    
    prependChild: (view) ->
      @renderChild(view)
      @$el.prepend(view.el)

    renderChildInto: (view, container) ->
      @renderChild(view)
      @$(container).empty().append(view.el)
    
    appendChildInto: (view, container) ->
      @renderChild(view)
      @$(container).append(view.el)
    
    appendChildAfter: (view, container) ->
      @renderChild(view)
      @$(container).after(view.el)
    
    prependChildInto: (view, container) ->
      @renderChild(view)
      @$(container).prepend(view.el)
    
    _leaveChildren: ->
      @children.chain().clone().each( (view) ->
        view.leave() if (view.leave)
      )

    _removeFromParent: ->
      @parent.removeChild(@) if (@parent)

    removeChild: (view) ->
      index = @children.indexOf(view)
      @children.splice(index, 1)