# The Monitoring Cage View
# Represents an extended view for the monitoring UI
window.UserCageMonitoringView = window.UserCageView.extend({

  # View represented as a div
  tagName:  "div"

  # Classes to apply to view
  className: "user_cage ui-helper-clearfix dialog"

  attributes: {
    title: "Cage Monitor View"
  }

  # handle UI events
  events: {
    "click  .clean"               : "clean"
    "click  .feed"                : "feed"
    "click  .send_message"        : "sendMessage"
  }

  sendMessage: (event) ->
    window.Application.appView.launchMessageDialog()

  # add an animal as a sub-view
  addOneAnimalIfAppropriate: (animal) ->
    if animal.get('cage_id') == @model.id
      view = new window.UserAnimalMonitoringView({model: animal})
      @$('.animal_in_cage_list').append(view.render().el)
    this

  # add all animals as a sub-view
  addAllAnimals: ->
    window.Application.animalCollection.each(@addOneAnimalIfAppropriate, this)
    this

  # add an employee as a sub-view
  addOneEmployeeIfAppropriate: (employee) ->
    if employee.get('cage_id') == @model.id
      view = new window.UserEmployeeMonitoringView({model: employee})
      @$('.employee_in_cage_list').append(view.render().el)
    this

  # add all employees as a sub-view
  addAllEmployees: ->
    window.Application.employeeCollection.each(@addOneEmployeeIfAppropriate, this)
    this

  # add an entrance as a sub-view
  addOneEntrance: (entrance) ->
    view = new window.UserEntranceMonitoringView({model: entrance})

    @$('.entrances_list').append(view.render().el)
    this

  # add all entrances as a sub-view
  addAllEntrances: ->
    @model.entrances.each(@addOneEntrance, this)
    this

  updateElemCageContent: ->
    $(@el).html(window.UserCageMonitoringView.template({
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

    if @model.isSomeoneInTheCage()
      @$('.no_alerts_place_holder').hide()
      @$('.someone_in_cage_alert').show()
    else
      @$('.someone_in_cage_alert').hide()

    if @model.isADoorOpen()
      @$('.no_alerts_place_holder').hide()
      @$('.door_open_alert').show()
    else
      @$('.door_open_alert').hide()

    if @model.isCageEmpty()
      @$('.no_alerts_place_holder').hide()
      @$('.cage_empty_alert').show()
    else
      @$('.cage_empty_alert').hide()
      @updateElemCageImages( @$('.images') )

    @addAllEmployees()
    @addAllAnimals()

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
    '<div class="cage_alerts">' +
      '<h2>Alerts</h2>' +
      '<p class="no_alerts_place_holder">No Current Alerts</p>' +
      '<p class="cage_empty_alert error">Cage Empty</p>' +
      '<p class="someone_in_cage_alert error">Someone Is In The Cage</p>' +
      '<p class="door_open_alert error">A Door Is Open</p>' +
    '</div>' +
    '<h1 class="cage_name"><%= model["name"] %></h1>' +
    '<div class="icons">' +
      '<img class="alarm_state" title="warning: cage needs attention" alt="warning: cage needs attention" src="/assets/alarm_icon.png"></img>' +
      '<img class="human_present" title="warning: human inside the cage" alt="human inside the cage icon" src="/assets/in_cage_icon.png"></img>' +
      '<img class="lights_on" title="light on in cage" alt="light on in cage icon" src="/assets/light_bulb_icon.png"></img>' +
    '</div>' +
    '<div class="cage_content">' +
      '<div class="actions">' +
        '<button class="send_message">Send Message</button>' +
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
      '<div class="entrances_list"></div>' +
      '<div class="animal_list">' +
        '<h2>Animals In The Cage</h2>' +
        '<div class="animal_in_cage_list"></div>' +
        '<div class="images"></div>' +
      '</div>' +
      '<div class="employee_list">' +
        '<h2>Employees In The Cage</h2>' +
        '<div class="employee_in_cage_list"></div>' +
      '</div>' +
    '</div>'
  )
})
