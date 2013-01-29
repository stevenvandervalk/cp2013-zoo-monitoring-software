# The Door View
# Represented as a div
window.UserDoorSensorView = Backbone.View.extend({

  # view represented as a div
  tagName:  "div"
  className: "user_door_view"

  initialize: ->
    # listen for change events on model
    @model.bind('change', this.render, this)
    @model.bind('destroy', this.remove, this)

  # listen for user interactions
  events: {
    "change .door_open_checkbox"  : "toggleDoorOpen"
    "change .door_locked_checkbox"  : "toggleDoorLocked"
  }

  # function to destroy associated model
  destroy: ->
    @model.destroy()

  # toggle the door open/closed state
  toggleDoorOpen: (event) ->
    open = false
    if $(event.target).is(':checked')
        open = true

    # Note: not silent - will cause a change event
    @model.set({ open: open })
    @model.save()
    this

  # toggle the door locked/unlocked state
  toggleDoorLocked: (event) ->
    locked = false
    if $(event.target).is(':checked')
        locked = true

    # Note: not silent - will cause a change event
    @model.set({ locked: locked })
    @model.save()
    this

  # render this view
  render: ->
    # render the template
    @$el.html(window.UserDoorSensorView.template({
      model: @model.toJSON()
    }))

    # update view based on door open/closed state
    if @model.get('open')
      @$('.door_open_checkbox').attr('checked', true);
      @$('.door_open').addClass('door_is_open')
      @$('.door_open').removeClass('door_is_closed')
    else
      @$('.door_open_checkbox').attr('checked', false);
      @$('.door_open').addClass('door_is_closed')
      @$('.door_open').removeClass('door_is_open')

    # update view based on door locked/unlocked state
    if @model.get('locked')
      if ! @model.get('open')
        @$('.door_open_checkbox').attr('disabled', true);

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
    '<h4>Door</h4>' +
    '<div class="door_content">' +
      '<p>' +
        '<span class="door_open"><input class="door_open_checkbox" type="checkbox" name="open" value="open" /></span>' +
        '<span class="door_locked"><input class="door_locked_checkbox" type="checkbox" name="locked" value="locked" /></span>' +
      '</p>' +
    '</div>'
  )
})
