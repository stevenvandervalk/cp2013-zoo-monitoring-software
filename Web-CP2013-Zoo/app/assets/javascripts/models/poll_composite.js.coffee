# A composite model to allow for the polling of various collections.
# All collections are treated as there base type collection.
#
# This code demonstrates both the Composite Pattern, and the
# Liskov Substitution Principle.
#
# The command pattern is shown via the use of the poll collection to act as a composite
# of all pollable classes.
#
# LSP is shown in that the collection instances can be substituted with
# subtype collections, without affecting the operation of this code.
# All collections are simply treated as their base class type (collection).
window.PollComposite = Backbone.Model.extend({
  initialize: ->
    @pollable_array = []
    null

  add: (collection) ->
    @pollable_array.push(collection)
    this

  poll: ->
    _.each @pollable_array, (collection) ->
      collection.fetch({update: true, removeMissing: true})
})
