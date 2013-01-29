# Animal Collection
window.AnimalCollection = Backbone.Collection.extend({
  # Collection's associated model
  model: window.AnimalModel

  # URL to RESTful api
  url: ->
    '/animals'

})
