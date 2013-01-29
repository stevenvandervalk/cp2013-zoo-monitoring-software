# The Door View
# Represented as a div
window.UserDoorView = Backbone.View.extend({

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

  # render this view
  render: ->
    # render the template
    @$el.html(window.UserDoorView.template({
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

    this

}, {
  # template for door view
  template: _.template(
    '<h3>Door</h3>' +
    '<div class="door_content">' +
      '<p>' +
        '<span class="door_open"><input class="door_open_checkbox" type="checkbox" name="open" value="open" /></span>' +
      '</p>' +
    '</div>'
  )
})
