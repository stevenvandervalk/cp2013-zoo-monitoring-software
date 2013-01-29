# The Entrance View
# Represented as a single row in the entrances table
window.AdminEntranceView = Backbone.View.extend({

  # View represents a single table row
  tagName:  "tr"

  initialize: ->
    # door list sub view starts closed
    @closed=true

    # listen for changes on entrance model
    @model.bind('change', this.render, this)
    @model.bind('destroy', this.remove, this)

    # listen for changes on doors collection
    @model.doors.bind('change',  this.render, this)
    @model.doors.bind('destroy', this.render, this)
    @model.doors.bind('reset',   this.render, this)
    @model.doors.bind('add',     this.render, this)

    this

  # handle human interaction events
  events: {
    "click  .add_door"              : "addDoor"
    "click  .remove_entrance"       : "destroy"
    "click  caption.doors_caption"  : "hideShow"
  }

  # toggle the doors sub view open/closed
  hideShow: ->
    @closed = !@closed
    @render()

    null

  # destroy the entrance model associated with this view
  destroy: ->
    @model.destroy()

  # add a door to the doors collection
  addDoor: ->
    @model.doors.create()
    # ensure that the door collection sub view is open
    @closed=false
    @render()

  # Add a door to the doors list sub view
  addOneDoor: (door) ->
    view = new window.Views['door']({model: door})

    @$('table.doors_table > tbody').append(view.render().el)
    null

  # Add all doors to the door list sub-view
  addAllDoors: ->
    @model.doors.each(@addOneDoor, this)

  # render this view
  render: ->

    # determine if the doors list sub view should be closed
    closedClass="shown"
    if @closed
        closedClass="closed"

    # render this view
    @$el.html(window.AdminEntranceView.template({
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
  # the template for the entrance view
  template: _.template(
    '<td>' +
      '<table class="doors_table">' +
        '<caption class="doors_caption <%= css["closedClass"] %>"><%= doors["length"] %> doors</caption>' +
        '<thead>' +
          '<tr><th>open?</th><th></th></tr>' +
        '</thead>' +
        '<tbody>' +
        '</tbody>' +
      '</table>' +
      '<button class="add_door">Add A Door</button>' +
    '</td>' +
    '<td><button class="remove_entrance">Remove Entrance</button></td>'
  )
})
