# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# Runs when document ready
window.AdminApplication = _.extend({
  defineViews: ->
    window.Views = {
      cage: AdminCageView
      entrance: AdminEntranceView
      door: AdminDoorView
      employee: AdminEmployeeView
      animal: AdminAnimalView
    }

  defineCollections: ->
    # Create a cage collection
    @cageCollection = new window.CageCollection
    # Create an employee collection
    @employeeCollection = new window.EmployeeCollection
    # Create an animal collection
    @animalCollection = new window.AnimalCollection

  updateCollections: ->
    # Fetch all the cages within the collection
    @cageCollection.fetch()

    # Fetch all the employees within the collection
    @employeeCollection.fetch()

    # Fetch all the animals within the collection
    @animalCollection.fetch()

  render: ->
    # Instantiate the admin application view. Set the application view to the #admin_index_container
    # Pass in our cage collection to the initializer
    appView = new window.AdminApplicationView({
      el: "#admin_index_container",
      cageCollection: @cageCollection,
      employeeCollection: @employeeCollection,
      animalCollection: @animalCollection
    })
}, window.CommonApplicationInterface)
