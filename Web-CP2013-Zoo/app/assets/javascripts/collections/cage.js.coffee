# Cage Collection
window.CageCollection = Backbone.Collection.extend({
  # Collection's associated model
  model: window.CageModel

  # URL to RESTful api
  url: ->
    '/cages'

})
