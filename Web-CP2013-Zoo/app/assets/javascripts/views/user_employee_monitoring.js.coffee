# The Employee View
# Represented as a div
window.UserEmployeeMonitoringView = Backbone.View.extend({

  # view represented as a div
  tagName:  "div"
  className: "employee"

  # initialize the view
  initialize: ->
    @closed=true
    @model.bind('change', this.render, this)
    @model.bind('destroy', this.remove, this)

    @model.messages.bind('change',  this.render, this)
    @model.messages.bind('destroy', this.render, this)
    @model.messages.bind('reset',   this.render, this)
    @model.messages.bind('add',     this.render, this)
    this


  # destory the associated model
  destroy: ->
    @model.destroy()

  # add a message as a sub-view
  addOneMessage: (door) ->
    view = new UserMessageMonitoringView({model: door})

    @$('.message_list').append(view.render().el)
    null

  # add all messages as sub-views
  addAllMessages: ->
    @model.messages.each(@addOneMessage, this)

  # render this view
  render: ->

    closedClass="shown"
    if @closed
        closedClass="closed"

    # render the template
    @$el.html(window.UserEmployeeMonitoringView.template({
      model: @model.toJSON()
      messages: {
        length: @model.messages.length
      }
    }))

    # add all the door sub-views
    @addAllMessages()

    this

}, {
  # the Door template
  template: _.template(
    '<%= model["name"] %> (<%= model["employee_id"] %>)' +
    '<div class="message_list"></div>'
  )
})
