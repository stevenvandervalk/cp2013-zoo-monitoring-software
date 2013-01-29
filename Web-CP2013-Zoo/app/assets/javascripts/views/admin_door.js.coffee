# The Door View
# Represented as a single row in the doors table
window.AdminDoorView = Backbone.View.extend({

  # View represents a table row
  tagName:  "tr"

  # View listens to change events on the associated door model
  initialize: ->
    @model.bind('change', this.render, this)
    @model.bind('destroy', this.remove, this)

  # List of human interaction events to act on
  events: {
    "click  .remove_door"         : "destroy"
    "change .door_open_checkbox"  : "toggleDoorOpen"
  }

  # Function to destory associated door model
  destroy: ->
    @model.destroy()

  # update the door open state of the cage
  toggleDoorOpen: (event) ->
    open = false
    if $(event.target).is(':checked')
        open = true

    @model.set({ open: open }, {silent: true})
    @model.save()
    this

  # render the door
  render: ->
    @$el.html(window.AdminDoorView.template({
      model: @model.toJSON()
    }))

    # update the door check box state based on model
    if @model.get('open')
        @$('.door_open_checkbox').attr('checked', true);
    else
        @$('.door_open_checkbox').attr('checked', false);

    this

}, {
  template: _.template(
    '<td><input class="door_open_checkbox" type="checkbox" name="open" value="open" /></td>' +
    '<td><button class="remove_door">Remove Door</button></td>'
  )
})
