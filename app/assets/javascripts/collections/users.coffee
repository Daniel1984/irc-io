define [
  'models/user'
  'backbone'
  ], (User, Backbone) ->
    
    class Users extends Backbone.Collection
      model: User