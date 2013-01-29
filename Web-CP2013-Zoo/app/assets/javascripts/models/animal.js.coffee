# Animal Model
window.AnimalModel = Backbone.Model.extend({

  # Initialize Animal model
  initialize: ->
    null

  # default value for a new instance of animal
  defaults: {
    animal_id: ""
    name: ""
  }

})
