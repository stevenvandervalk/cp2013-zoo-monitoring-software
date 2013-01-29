# Entrance Collection
window.EntranceCollection = Backbone.Collection.extend({
  # Collection's associated model
  model: window.EntranceModel

  # RESTful API's URL
  # url is relative to cage url
  url: ->
    @cage.url() + '/entrances'

  # Set the parent cage when initializing
  initialize: (models, options) ->
    @cage = options.cage
    null
})
