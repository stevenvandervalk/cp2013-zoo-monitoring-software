# Base Cage Interface, contains only the default values of the cage.
window.BaseCage = {
  # default value for a new instance of cage
  defaults: {
    size: 5
    category: "open"
    name: "cage name"
    created_at: ""
    updated_at: ""
    longitude: 0
    latitude: 0
    date_last_fed: ""
    date_last_cleaned: ""
    lights_on: false
  }
}

# Interface to handle the processing of the entrace information of a cage
window.CageEntranceProcessing = _.extend(window.BaseCage, {
  # Initialize Cage model
  initialize: ->
    # create an inner entrances collection
    @entrances = new window.EntranceCollection([], {
      cage: this
    })

    # if the cage is not new, fetch the associated entrances
    if !@isNew()
      @entrances.fetch()

    # when the id of the cage changes, fetch the associated entrances
    @on "change:id", ->
      @entrances.fetch()

    @poll()

    null

  poll: ->
    setInterval(
      =>
        @entrances.fetch({update: true, removeMissing: true})
      5000
    )
    this
})

# Interface to handle the processing of the alarm information of a cage
window.CageAlarmProcessing = _.extend(window.BaseCage, {
  # is the cage in an alarm state?
  inAlarmState: () ->
    ( @isSomeoneInTheCage() or @isCageEmpty() or @isADoorOpen() )

  # is someone in the cage?
  isSomeoneInTheCage: () ->
    return_value = false
    eachEmployee = (employee) =>
      if employee.get('cage_id') == @id
        return_value = true

    window.Application.employeeCollection.each(eachEmployee, this)

    return_value

  # is the cage empty? (no animals inside)
  isCageEmpty: () ->
    return_value = true
    eachAnimal = (animal) =>
      if animal.get('cage_id') == @id
        return_value = false

    window.Application.animalCollection.each(eachAnimal, this)

    return_value

  # is a cage door open?
  isADoorOpen: () ->
    door_open = false
    @entrances.each (entrance) ->
      entrance.doors.each (door) ->
        if door.get('open')
          door_open = true

    door_open
})

# Full Cage Model
# Combines and extends the 2 processing interfaces of the cage
window.CageModel = Backbone.Model.extend(
  _.extend(
    {},
    window.CageEntranceProcessing,
    window.CageAlarmProcessing
  )
) 
