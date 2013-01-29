# The Animal View
# Represented as a div
window.UserAnimalMonitoringView = Backbone.View.extend({

  # view represented as a div
  tagName:  "div"
  className: "animal"

  # initialize the view
  initialize: ->
    @closed=true
    @model.bind('change', this.render, this)
    @model.bind('destroy', this.remove, this)
    this


  # destory the associated model
  destroy: ->
    @model.destroy()


  # render this view
  render: ->

    closedClass="shown"
    if @closed
        closedClass="closed"

    # render the template
    @$el.html(window.UserAnimalMonitoringView.template({
      model: @model.toJSON()
    }))

    this

}, {
  # the Door template
  template: _.template(
    '<%= model["name"] %> (<%= model["animal_id"] %>)'
  )
})
