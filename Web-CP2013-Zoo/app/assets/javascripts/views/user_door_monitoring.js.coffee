# The Door View
# Represented as a div
window.UserDoorMonitoringView = Backbone.View.extend({

  # view represented as a div
  tagName:  "div"
  className: "user_door_view"

  initialize: ->
    # listen for change events on model
    @model.bind('change', this.render, this)
    @model.bind('destroy', this.remove, this)

  # listen for user interactions
  events: {
    "change .door_locked_checkbox"  : "toggleDoorLocked"
  }

  # function to destroy associated model
  destroy: ->
    @model.destroy()

  # toggle the door locked/unlocked state
  toggleDoorLocked: (event) ->
    locked = false
    if $(event.target).is(':checked')
        locked = true

    # Note: not silent - will cause a change event
    # Ensure the door is not open, when moving to a locked state
    @model.set({ locked: locked })
    @model.save()
    this

  # render this view
  render: ->
    # render the template
    @$el.html(window.UserDoorMonitoringView.template({
      model: @model.toJSON()
    }))

    # update view based on door open/closed state
    if @model.get('locked')
        @$('.door_locked_checkbox').attr('checked', true);
        @$('.door_locked').addClass('door_is_locked')
        @$('.door_locked').removeClass('door_is_unlocked')
    else
        @$('.door_locked_checkbox').attr('checked', false);
        @$('.door_locked').addClass('door_is_unlocked')
        @$('.door_locked').removeClass('door_is_locked')

    this

}, {
  # template for door view
  template: _.template(
    '<h3>Door</h3>' +
    '<div class="door_content">' +
      '<p>' +
        '<span class="door_locked"><input class="door_locked_checkbox" type="checkbox" name="locked" value="locked" /></span>' +
      '</p>' +
    '</div>'
  )
})
