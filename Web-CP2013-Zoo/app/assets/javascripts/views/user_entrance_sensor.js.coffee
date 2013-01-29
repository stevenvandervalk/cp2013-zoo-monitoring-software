# The Entrance View
# Represented as a div
window.UserEntranceSensorView = Backbone.View.extend({

  # view represented as a div
  tagName:  "div"
  className: "user_entrance_view"

  # initialize the view
  initialize: ->
    @closed=true
    @model.bind('change', this.render, this)
    @model.bind('destroy', this.remove, this)

    @model.doors.bind('change',  this.render, this)
    @model.doors.bind('destroy', this.render, this)
    @model.doors.bind('reset',   this.render, this)
    @model.doors.bind('add',     this.render, this)
    this


  # destory the associated model
  destroy: ->
    @model.destroy()

  # add a door as a sub-view
  addOneDoor: (door) ->
    view = new window.UserDoorSensorView({model: door})

    @$('.doors_list').append(view.render().el)
    null

  # add all doors as sub-views
  addAllDoors: ->
    @model.doors.each(@addOneDoor, this)

  # render this view
  render: ->

    closedClass="shown"
    if @closed
        closedClass="closed"

    # render the template
    @$el.html(window.UserEntranceSensorView.template({
      model: @model.toJSON()
      doors: {
        length: @model.doors.length
      }
      css: {
        closedClass: closedClass
      }
    }))

    # add all the door sub-views
    @addAllDoors()

    this

}, {
  # the Door template
  template: _.template(
    '<h3>Entrance</h3>' +
    '<div class="doors_list">' +
    '</div>'
  )
})
