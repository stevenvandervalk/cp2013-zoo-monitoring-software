# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# Runs when document ready
window.Application = _.extend({
  defineViews: ->
    window.Views = {
      cage: UserCageView
      entrance: UserEntranceView
      door: UserDoorView
    }

  defineCollections: ->
    # Create a cage collection
    @cageCollection = new window.CageCollection
    @employeeCollection = new window.EmployeeCollection
    @animalCollection = new window.AnimalCollection

    # Create a poll composite of our collections
    @pollComposite = new window.PollComposite()
    @pollComposite.add(@cageCollection)
    @pollComposite.add(@employeeCollection)
    @pollComposite.add(@animalCollection)

  updateCollections: ->
    null

  render: ->
    @appView = new window.UserApplicationView({
      id: "map_canvas",
      cageCollection:     @cageCollection,
      employeeCollection: @employeeCollection,
      animalCollection:   @animalCollection
    })

    google.maps.event.addListenerOnce(
      @appView.map,
      'bounds_changed',
      =>
        setInterval(
          =>
            @pollComposite.poll()
          10000
        )
    )
}, window.CommonApplicationInterface)
