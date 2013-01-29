# Door Collection
window.DoorCollection = Backbone.Collection.extend({
  # Collection's associated model
  model: window.DoorModel

  # RESTful API's URL
  # url is relative to entrance url
  url: ->
    @entrance.url() + '/doors'

  # Set the parent entrance when initializing
  initialize: (models, options) ->
    @entrance = options.entrance
    null
})
