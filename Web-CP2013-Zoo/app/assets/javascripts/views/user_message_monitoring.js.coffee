# The Message View
# Represented as a div
window.UserMessageMonitoringView = Backbone.View.extend({

  # view represented as a div
  tagName:  "div"
  className: "employee_message"

  initialize: ->
    # listen for change events on model
    @model.bind('change', this.render, this)
    @model.bind('destroy', this.remove, this)

  # listen for user interactions
  events: {
    "click  .mark_as_read"               : "destroy"
  }

  # function to destroy associated model
  destroy: ->
    @model.destroy()

  # render this view
  render: ->
    # render the template
    @$el.html(window.UserMessageMonitoringView.template({
      model: @model.toJSON()
    }))

    this

}, {
  # template for door view
  template: _.template(
    '<p><%= model["message"] %></p><button class="mark_as_read">mark as read</button>'
  )
})
