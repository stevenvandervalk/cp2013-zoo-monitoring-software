# The Cage View
# Represented as a single row in the cage table
window.AdminCageView = Backbone.View.extend({

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

    # re-render when the entrances collection of the cage changes
    @model.entrances.bind('change', this.render, this)
    @model.entrances.bind('destroy', this.render, this)
    @model.entrances.bind('reset', this.render, this)
    @model.entrances.bind('add', this.render, this)

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
    "change .cage_description"    : "updateDescription"
    "change .cage_longitude"      : "updateLongitude"
    "change .cage_latitude"       : "updateLatitude"
    "change .size"                : "updateSize"
    "change .cage_name"           : "updateName"
    "change .human_present"       : "toggleHumanPresent"
    "change .category"            : "updateCategory"
    "click  .add_entrance"        : "addEntrance"
    "click  .remove_cage"         : "destroy"
    "click  caption.entrances_caption"              : "hideShow"
  }

  # toggle the hidden state of the entrances
  hideShow: ->
    @closed = !@closed
    @render()

    null

  # feed the animal in the cage
  feed: ->
    d = new Date()
    @model.set({ date_last_fed: window.ISODateString.getString(d)})
    @model.save()
    this

  # clean the cage
  clean: ->
    d = new Date()
    @model.set({ date_last_cleaned: window.ISODateString.getString(d)})
    @model.save()
    this


  # update the human present state of the cage
  toggleHumanPresent: (event) ->
    humanPresent= false
    # human is present if human present is checked
    if $(event.target).is(':checked')
        humanPresent = true

    # update the human present state of the model
    # suppress change event on the model
    @model.set({ human_present: humanPresent}, {silent: true})
    # save the changes
    @model.save()

    this

  # add an entrance to the cage
  # opens the entrances sub-view
  addEntrance: ->
    @model.entrances.create()
    @closed=false
    @render()

  # add an entrance as a sub-view
  addOneEntrance: (entrance) ->
    view = new window.Views['entrance']({model: entrance})

    @$('table.entrances_table > tbody').append(view.render().el)
    null

  # add all entrances as sub-views
  addAllEntrances: ->
    @model.entrances.each(@addOneEntrance, this)

  # destroy the cage model
  destroy: ->
    @model.destroy()


  # update the category (type) of the cage
  updateCategory: (event) ->
    target = event.target
    category = target.value
    @model.set({ category: category}, {silent: true})
    @model.save()
    this

  # update the size of the cage
  updateSize: (event) ->
    target = event.target
    size = target.value
    @model.set({ size: size}, {silent: true})
    @model.save()
    this

  # update the lonitude of the cage
  updateLongitude: (event) ->
    target = event.target
    longitude = target.value
    @model.set({ longitude: longitude }, {silent: true})
    @model.save()
    this

  # update the latitude of the cage
  updateLatitude: (event) ->
    target = event.target
    latitude = target.value
    @model.set({ latitude: latitude }, {silent: true})
    @model.save()
    this

  # update the description of the cage
  updateDescription: (event) ->
    target = event.target
    description = target.value
    @model.set({ description: description }, {silent: true})
    @model.save()
    this

  # update the name of the cage
  updateName: (event) ->
    target = event.target
    name = target.value
    @model.set({ name: name}, {silent: true})
    @model.save()
    this

  # render the cage
  render: ->
    # determine if the entrances sub view should be shown
    closedClass="shown"
    if @closed
        closedClass="closed"

    # render the view template
    @$el.html(window.AdminCageView.template({
      model: @model.toJSON()
      entrances: {
        length: @model.entrances.length
      }
      css: {
        closedClass: closedClass
      }
    }))
    # add all the entrances to the view
    @addAllEntrances()

    # update the human present checkbox state
    if @model.get('human_present')
        @$('.human_present').attr('checked', true)
    else
        @$('.human_present').attr('checked', false)

    # update the category drop-down list
    @$('.category').val(@model.get('category'))

    this

}, {
  # The view of the cage
  template: _.template(
    '<td><input type="text" class="cage_name" value="<%= model["name"] %>"/></td>' +
    '<td>' +
      '<select class="category">' +
        '<option value="open">open</option>'+
        '<option value="mesh">mesh</option>'+
        '<option value="glass">glass</option>'+
        '<option value="marine">marine</option>'+
      '</select>' +
    '</td>' +
    '<td><input type="text" class="size" value="<%= model["size"] %>"/></td>' +
    '<td><input type="text" class="cage_longitude" value="<%= model["longitude"] %>"/></td>' +
    '<td><input type="text" class="cage_latitude" value="<%= model["latitude"] %>"/></td>' +
    '<td><%= model["date_last_fed"] %></td>' +
    '<td><%= model["date_last_cleaned"] %></td>' +
    '<td>' +
      '<table class="entrances_table">' +
        '<caption class="entrances_caption <%= css["closedClass"] %>"><%= entrances["length"] %> entrances</caption>' +
        '<thead>' +
          '<tr><th>doors</th><th></th></tr>' +
        '</thead>' +
        '<tbody>' +
        '</tbody>' +
      '</table>' +
      '<button class="add_entrance">Add An Entrance</button>' +
    '</td>' +
    '<td>' +
    '<button class="remove_cage">Remove Cage</button><br />' +
    '</td>'
  )
})
