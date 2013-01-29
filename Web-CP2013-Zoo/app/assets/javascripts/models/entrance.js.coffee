# Entrance Model
window.EntranceModel = Backbone.Model.extend({

  initialize: ->
    # Create inner doors collection
    @doors = new window.DoorCollection([], {
      entrance: this
    })

    # if this isn't new, update the doors collection
    if !@isNew()
      @doors.fetch()

    # when the id changes, update the doors collection
    @on "change:id", ->
      @doors.fetch()

    @poll()

    null

  poll: ->
    setInterval(
      =>
        @doors.fetch({update: true, removeMissing: true})
      5000
    )
    this

})
