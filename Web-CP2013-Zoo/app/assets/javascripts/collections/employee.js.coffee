# Employee Collection
window.EmployeeCollection = Backbone.Collection.extend({
  # Collection's associated model
  model: window.EmployeeModel

  # URL to RESTful api
  url: ->
    '/employees'

})
