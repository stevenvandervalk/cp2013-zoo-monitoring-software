# Message Collection
window.MessageCollection = Backbone.Collection.extend({
  # Collection's associated model
  model: window.MessageModel

  # RESTful API's URL
  # url is relative to employee url
  url: ->
    @employee.url() + '/messages'

  # Set the parent employee when initializing
  initialize: (models, options) ->
    @employee = options.employee
    null


})
