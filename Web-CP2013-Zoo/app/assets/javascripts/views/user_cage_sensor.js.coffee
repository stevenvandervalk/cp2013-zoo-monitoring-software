# The Sensor Cage View
# Represents an extended view for the sensor UI
window.UserCageSensorView = window.UserCageView.extend({

  # View represented as a div
  tagName:  "div"

  # Classes to apply to view
  className: "user_cage ui-helper-clearfix dialog"

  attributes: {
    title: "Cage Sensor View"
  }

  # handle UI events
  events: {
    "click  .clean"                          : "clean"
    "click  .feed"                           : "feed"
    "click  .move_employee_to_cage"          : "moveEmployeeToCage"
    "click  .remove_employee_from_cage"      : "removeEmployeeFromCage"
    "click  .move_animal_to_cage"            : "moveAnimalToCage"
    "click  .remove_animal_from_cage"        : "removeAnimalFromCage"
    "click  .turn_lights_on"                 : "turnLightsOn"
    "click  .turn_lights_off"                : "turnLightsOff"
  }


  # add an entrance as a sub-view
  addOneEntrance: (entrance) ->
    view = new window.UserEntranceSensorView({model: entrance})

    @$('.entrances_list').append(view.render().el)
    this

  # add all entrances as a sub-view
  addAllEntrances: ->
    @model.entrances.each(@addOneEntrance, this)
    this

  updateElemCageContent: ->
    $(@el).html(window.UserCageSensorView.template({
      model: @model.toJSON()
      entrances: {
        length: @model.entrances.length
      }
    }))

    # add all entrance subviews
    @addAllEntrances()

    this

  # render this view
  render: ->
    if @dialog == null
      @dialog = @$el.dialog({
        modal: true
        width: $(window).width() * 0.8
        height: $(window).height() * 0.8
      })

    @updateElemCageContent()

    if @model.get('lights_on')
      @$('.turn_lights_on').hide()
      @$('.turn_lights_off').show()
    else
      @$('.turn_lights_on').show()
      @$('.turn_lights_off').hide()

    if !@model.isCageEmpty()
      @updateElemCageImages( @$('.images') )

    @$('.move_employee_to_cage_div').hide()

    eachEmployee = (employee) =>
      if employee.get('cage_id') == @model.id
        @$('.employee_in_cage_list').append('<p>' + employee.get('name') + ' (' + employee.get('employee_id') +  ')<button class="remove_employee_from_cage" employee_id="' + employee.id + '">Remove From Cage</button></p>')
      else
        @$('.move_employee_to_cage_div').show();
        @$('.move_employee_to_cage_list').append('<option id="employee_id" value="' + employee.id + '">' + employee.get("name") + '</option>')

    window.Application.employeeCollection.each(eachEmployee, this)

    @$('.move_animal_to_cage_div').hide()

    eachAnimal = (animal) =>
      if animal.get('cage_id') == @model.id
        @$('.animal_in_cage_list').append('<p>' + animal.get('name') + ' (' + animal.get('animal_id') +  ')<button class="remove_animal_from_cage" animal_id="' + animal.id + '">Remove From Cage</button></p>')
      else
        @$('.move_animal_to_cage_div').show();
        @$('.move_animal_to_cage_list').append('<option id="animal_id" value="' + animal.id + '">' + animal.get("name") + '</option>')

    window.Application.animalCollection.each(eachAnimal, this)

    if @model.isSomeoneInTheCage()
      @$('.human_present').show()
    else
      @$('.human_present').hide()

    if @model.get('lights_on')
      @$('.lights_on').show()
    else
      @$('.lights_on').hide()

    if @model.inAlarmState()
      @$('.alarm_state').show()
    else
      @$('.alarm_state').hide()

    addEntranceToView = (entrance) ->
      if entrance.doors.size() > 0
        entranceDiv = $('<span class="entrance"></span>')
        addDoorToEntrance = (door) ->
          if door.get('open')
            entranceDiv.append('<img class="door_open" title="warning: door is open" alt="open door icon" src="/assets/door_open_icon.png"></img>')
          else if door.get('locked') and !door.get('open')
            entranceDiv.append('<img class="door_locked" title="door is locked" alt="locked door icon" src="/assets/door_locked_icon.png"></img>')
          else
            entranceDiv.append('<img class="door_closed" title="closed door" alt="closed door icon" src="/assets/door_closed_icon.png"></img>')

        entrance.doors.each(addDoorToEntrance, entrance)

        @$('.icons').append(entranceDiv)

    @model.entrances.each(addEntranceToView, this)

    this

}, {
  # template for the Cage view
  template: _.template(
    '<h1 class="cage_name"><%= model["name"] %></h1>' +
    '<div class="icons">' +
      '<img class="alarm_state" title="warning: cage needs attention" alt="warning: cage needs attention" src="/assets/alarm_icon.png"></img>' +
      '<img class="human_present" title="warning: human inside the cage" alt="human inside the cage icon" src="/assets/in_cage_icon.png"></img>' +
      '<img class="lights_on" title="light on in cage" alt="light on in cage icon" src="/assets/light_bulb_icon.png"></img>' +
    '</div>' +
    '<div class="cage_content">' +
      '<div class="actions">' +
        '<button class="feed">Feed Exhibit</button><br />' +
        '<button class="clean">Clean Cage</button><br />' +
        '<button class="turn_lights_on">Turn Lights On</button>' +
        '<button class="turn_lights_off">Turn Lights Off</button>' +
      '</div>' +
      '<p class="info">' +
        '<span class="category"><%= model["category"] %></span>' +
        '<span class="size"><%= model["size"] %></span>' +
        '<span class="longitude"><%= model["longitude"] %></span>' +
        '<span class="latitude"><%= model["latitude"] %></span>' +
        '<span class="date_last_fed"><%= model["date_last_fed"] %></span>' +
        '<span class="date_last_cleaned"><%= model["date_last_cleaned"] %></span>' +
        '<span class="lights_on"><%= model["lights_on"] %></span>' +
      '</p>' +
      '<div class="entrances_list">' +
        '<h2>Entrances</h2>' +
      '</div>' +
      '<div class="animal_list">' +
        '<h2>Animals In The Cage</h2>' +
        '<div class="animal_in_cage_list"></div>' +
        '<div class="move_animal_to_cage_div">' +
          '<select class="move_animal_to_cage_list" name="move_animal_to_cage_list"></select>' +
          '<button class="move_animal_to_cage">Move Animal To Cage</button>' +
        '</div>' +
        '<div class="images"></div>' +
      '</div>' +
      '<div class="employee_list">' +
        '<h2>Employees In The Cage</h2>' +
        '<div class="employee_in_cage_list"></div>' +
        '<div class="move_employee_to_cage_div">' +
          '<select class="move_employee_to_cage_list" name="move_employee_to_cage_list"></select>' +
          '<button class="move_employee_to_cage">Move Employee To Cage</button>' +
        '</div>' +
      '</div>' +
    '</div>'
  )
})
