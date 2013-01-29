# The Animal View
# Represented as a single row in the cage table
window.AdminAnimalView = Backbone.View.extend({

  # View represents row in cages table
  tagName:  "tr"

  initialize: ->
    # view starts open
    @closed=false

    # show the error state of the view if the cage fails a save test
    @model.bind('error', this.showError, this)
    # clear the error state if the model saves successfully
    @model.bind('sync', this.removeError, this)

    # if the model changes, re-render
    @model.bind('change', this.render, this)
    # remove this view if the model is destroyed
    @model.bind('destroy', this.remove, this)

  # show the model is an erroneous state
  showError: (model, err) ->
    # add an error class to the cage view
    @$el.addClass('error')

    # parse the errors from the server response
    errors = $.parseJSON(err.responseText)
    _.each(errors, (specific_error, specific_key) ->
      # alert the errors
      alert(specific_key + ": " + specific_error)
    )

    this

  # remove the error class from the view
  removeError: ->
    @$el.removeClass('error')
    this

  # handle different user interaction events within the view
  events: {
    "change .name"             : "updateName"
    "change .animal_id"      : "updateAnimalId"
    "click  .remove_animal"  : "destroy"
  }

  # destroy the cage model
  destroy: ->
    @model.destroy()

  # update the animal name in the cage
  updateName: (event) ->
    target = event.target
    name = target.value
    @model.set({ name: name}, {silent: true})
    @model.save()
    this

  # update the category (type) of the cage
  updateAnimalId: (event) ->
    target = event.target
    animal_id= target.value
    @model.set({ animal_id: animal_id}, {silent: true})
    @model.save()
    this

  # render the cage
  render: ->
    # render the view template
    @$el.html(window.AdminAnimalView.template({
      model: @model.toJSON()
    }))

    this

}, {
  # The view of the cage
  template: _.template(
    '<td><input type="text" class="animal_id" value="<%= model["animal_id"] %>"/></td>' +
    '<td><input type="text" class="name" value="<%= model["name"] %>"/></td>' +
    '<td>' +
    '<button class="remove_animal">Remove Animal</button><br />' +
    '</td>'
  )
})
