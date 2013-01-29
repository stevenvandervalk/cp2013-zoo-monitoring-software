# Employee Model
window.EmployeeModel = Backbone.Model.extend({

  # Initialize Employee model
  initialize: ->
    # create an inner messages collection
    @messages = new window.MessageCollection([], {
      employee: this
    })

    # if the cage is not new, fetch the associated entrances
    if !@isNew()
      @messages.fetch()

    # when the id of the employee changes, fetch the associated messages
    @on "change:id", ->
      @messages.fetch()

    @poll()

    null

  poll: ->
    setInterval(
      =>
        @messages.fetch({update: true, removeMissing: true})
      1000
    )
    this

  # default value for a new instance of employee
  defaults: {
    employee_id: ""
    name: ""
  }

})
