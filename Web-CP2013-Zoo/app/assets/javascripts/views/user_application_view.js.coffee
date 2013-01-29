# The MessageControl adds a control to the map that
# allows a user to send a message to an employee.
MessageControl = (controlDiv, app) ->

  # Set CSS styles for the DIV containing the control
  # Setting padding to 5 px will offset the control
  # from the edge of the map.
  controlDiv.style.padding = '5px'

  # Set CSS for the control border.
  controlUI = document.createElement('div')
  controlUI.style.backgroundColor = 'white'
  controlUI.style.borderStyle = 'solid'
  controlUI.style.borderWidth = '2px'
  controlUI.style.cursor = 'pointer'
  controlUI.style.textAlign = 'center'
  controlUI.title = 'Click to send a message to an employee'
  controlDiv.appendChild(controlUI)

  # Set CSS for the control interior.
  controlText = document.createElement('div')
  controlText.style.fontFamily = 'Arial,sans-serif'
  controlText.style.fontSize = '12px'
  controlText.style.paddingLeft = '4px'
  controlText.style.paddingRight = '4px'
  controlText.innerHTML = '<strong>Send Message</strong>'
  controlUI.appendChild(controlText)

  # Setup the click event listeners: simply set the map to Chicago.
  google.maps.event.addDomListener(controlUI, 'click', app.launchMessageDialog)

# The DayNightControl adds a control to the map that
# toggls day/night
DayNightControl = (controlDiv, app) ->

  # Set CSS styles for the DIV containing the control
  # Setting padding to 5 px will offset the control
  # from the edge of the map.
  controlDiv.style.padding = '5px'

  # Set CSS for the control border.
  controlUI = document.createElement('div')
  controlUI.style.backgroundColor = 'white'
  controlUI.style.borderStyle = 'solid'
  controlUI.style.borderWidth = '2px'
  controlUI.style.cursor = 'pointer'
  controlUI.style.textAlign = 'center'
  controlUI.title = 'Click to toggle day and night'
  controlDiv.appendChild(controlUI)

  # Set CSS for the control interior.
  controlText = document.createElement('div')
  controlText.style.fontFamily = 'Arial,sans-serif'
  controlText.style.fontSize = '12px'
  controlText.style.paddingLeft = '4px'
  controlText.style.paddingRight = '4px'
  controlText.innerHTML = '<strong>Day/Night</strong>'
  controlUI.appendChild(controlText)

  # Setup the click event listeners: simply set the map to Chicago.
  google.maps.event.addDomListener(controlUI, 'click', app.toggleDayNight)

# The CageUI (User) Application View
window.UserApplicationView = Backbone.View.extend({

  toggleDayNight: () ->
    @day = !@day

    if @day
      $('body').addClass("day")
      $('body').removeClass("night")
    else
      $('body').addClass("night")
      $('body').removeClass("day")


  launchMessageDialog: () ->
    $htmlElem = $(
      '<div title="Send Message">' +
      '<select class="employee_list">Send a Message</select><br />' +
      '<textarea class="message"></textarea><br />' +
      '</div>'
    )

    addEmployeeToList = (employee) ->
      $htmlElem.find('.employee_list').append('<option id="employee_id" value="' + employee.id + '">' + employee.get("name") + '</option>')
      null

    window.Application.appView.employeeCollection.each(addEmployeeToList)

    $htmlElem.dialog({
      height: 240
      modal: true
      buttons: {
        "Send": () ->
          employee_id = $( this ).find('.employee_list').val()
          inMessage = $( this ).find('.message').val()
          employee = window.Application.appView.employeeCollection.get(employee_id)
          message = employee.messages.create({
            'message': inMessage
          })
          $( this ).dialog( "close" )
        ,
        "Cancel": () ->
          $( this ).dialog( "close" );
      }
    })

  # View expects to exist as a div
  tagName:  "div"

  # Events the view should handle
  events: {
    "click #open_all_cages":  "openAllCages"
    "click #close_all_cages": "closeAllCages"
  }

  # Initialize the view
  # Takes the cage collection as an input
  initialize: (options) ->
    @cageCollection = options.cageCollection
    @cageCollection.bind('reset', @addAllCages, this)
    @cageCollection.bind('add', @addOneCage, this)

    @cageCollection.bind('add', @expandMapToIncludeMarker, this)
    @cageCollection.bind('remove', @expandMapToIncludeMarker, this)
    @cageCollection.bind('change:latitude', @expandMapToIncludeMarker, this)
    @cageCollection.bind('change:longitude', @expandMapToIncludeMarker, this)

    @employeeCollection = options.employeeCollection

    @animalCollection = options.animalCollection

    mapOptions = {
      center: new google.maps.LatLng(-19.32585, 146.756654)
      zoom: 18
      mapTypeId: google.maps.MapTypeId.HYBRID
      maxZoom: 18
    }

    @map = new google.maps.Map(document.getElementById(@id),
      mapOptions)

    @day = true
    $('body').addClass("day")
    $('body').removeClass("night")

    # Create the DIV to hold the control and call the MessageControl() constructor
    # passing in this DIV.
    messageControlDiv = document.createElement('div')
    @messageControl = new MessageControl(messageControlDiv, this)

    messageControlDiv.index = 1
    @map.controls[google.maps.ControlPosition.TOP_RIGHT].push(messageControlDiv)

    dayAndNightControlDiv = document.createElement('div')
    @dayAndNightControl = new DayNightControl(dayAndNightControlDiv, this)

    dayAndNightControlDiv.index = 1
    @map.controls[google.maps.ControlPosition.TOP_RIGHT].push(dayAndNightControlDiv)

    @firstMapExpansion = true

    this

  expandMapToIncludeMarker: ->

    new_map_bounds = new google.maps.LatLngBounds()

    @cageCollection.each( (model) ->
      cagePosition = new google.maps.LatLng(model.get('latitude'), model.get('longitude'))
      new_map_bounds.extend(cagePosition)
    )

    if @firstMapExpansion
      @firstMapExpansion = false
    else
#      new_map_bounds.union(@map.getBounds())

    unless new_map_bounds.equals(@map.getBounds())
      @map.fitBounds(new_map_bounds)

  # Open all cages
  # Opens every door on every entrance on every cage
  openAllCages: (event) ->
    @cageCollection.each (cage) ->
      cage.entrances.each (entrance) ->
        entrance.doors.each (door) ->
          door.set({ open: true})
          door.save()

    null

  # Close all cages
  # Closes every door on every entrance on every cage
  closeAllCages: ->
    @cageCollection.each (cage) ->
      cage.entrances.each (entrance) ->
        entrance.doors.each (door) ->
          door.set({ open: false })
          door.save()

    null

  # Add a single cage to the view
  addOneCage: (cage) ->
    view = new window.Views['cage']({model: cage, collection: @cageCollection})
    view.render()

  # Add all cages to the view
  addAllCages: (list) ->
    @cageCollection.each(@addOneCage, this);

})
