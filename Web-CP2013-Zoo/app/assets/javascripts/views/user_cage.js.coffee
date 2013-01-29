# The Cage View
# Represented as div
window.UserCageView = Backbone.View.extend({

  # View represented as a div
  tagName:  "div"

  # Classes to apply to view
  className: "user_cage ui-helper-clearfix popup"

  # initialize the view
  initialize: ->
    @marker = null
    @dialog = null
    @map = window.Application.appView.map

    # re-render when changes occur on model
    @model.bind('change', this.render, this)
    @model.bind('destroy', this.removeFromMap, this)
    @model.bind('remove', this.removeFromMap, this)

    window.Application.employeeCollection.on('all', this.render, this)
    window.Application.animalCollection.on('all', this.render, this)

    # re-render when entrances collection changes
    @model.entrances.bind('change', this.render, this)
    @model.entrances.bind('destroy', this.render, this)
    @model.entrances.bind('reset', this.render, this)
    @model.entrances.bind('add', this.render, this)

    @model.entrances.bind('reset', @bindToDoorsOnAllEntrance, this)
    @model.entrances.bind('add', @bindToDoors, this)

    # listen for changes on doors within collections
    @bindToDoorsOnAllEntrance(@model.entrances)

  # handle UI events
  events: {
    "click"                       : "launchView"
  }

  launchView: ->
    if (window.Mode == 'sensor')
      @launch_sensor_view()
    else
      @launch_monitor_view()

  turnLightsOn: (event) ->
    @model.set({ lights_on: true })
    @model.save()

  turnLightsOff: (event) ->
    @model.set({ lights_on: false })
    @model.save()

  removeAnimalFromCage: (event) ->
    animal_id = $(event.target).attr('animal_id')
    animal = window.Application.animalCollection.get(animal_id)
    animal.set({ cage_id: null })
    animal.save()
    this

  moveAnimalToCage: (event) ->
    animal_id = @$('.move_animal_to_cage_list').val()
    animal = window.Application.animalCollection.get(animal_id)
    animal.set({ cage_id: @model.id })
    animal.save()
    this

  removeEmployeeFromCage: (event) ->
    employee_id = $(event.target).attr('employee_id')
    employee = window.Application.employeeCollection.get(employee_id)
    employee.set({ cage_id: null })
    employee.save()
    this

  moveEmployeeToCage: (event) ->
    employee_id = @$('.move_employee_to_cage_list').val()
    employee = window.Application.employeeCollection.get(employee_id)
    employee.set({ cage_id: @model.id })
    employee.save()
    this

  launch_monitor_view: ->
    view = new window.UserCageMonitoringView({model: @model})
    view.render()
    this

  launch_sensor_view: ->
    view = new window.UserCageSensorView({model: @model})
    view.render()
    this

  bringToFront: ->
    window.UserCageView.lastZIndexUsed = window.UserCageView.lastZIndexUsed + 1
    @markerInfoWindow.setZIndex(window.UserCageView.lastZIndexUsed)

  # feed the exhibit
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

  # listen for changes on all doors on all entrances
  bindToDoorsOnAllEntrance: (entrances) ->
    @model.entrances.each(@bindToDoors, this, this)
    null

  # listen for changes on all associated doors
  bindToDoors: (entrance) ->
    entrance.doors.bind('change', this.render, this)
    entrance.doors.bind('destroy', this.render, this)
    entrance.doors.bind('reset', this.render, this)
    entrance.doors.bind('add', this.render, this)
    null

  removeFromMap: ->
    @marker.setMap(null)
    @remove()

  # destroy the model associated with this view
  destroy: ->
    @model.destroy()

  updateElemCageImages: (target_html_elem) ->

    cleared=false

    addAnimalImageIfAppropriate = (animal) ->
      if animal.get('cage_id') == @model.id
        $.getJSON(
          "http://api.flickr.com/services/feeds/photos_public.gne?jsoncallback=?",
          {
            per_page: 1
            tags: "wild " + animal.get('name')
            tagmode: "any"
            format: "json"
          },
          (data) =>
            if !cleared
              target_html_elem.empty()
              cleared = true
            $.each(data.items, (i,item) =>
              if ( i == 1 )
                return false
              $("<img/>").attr("src", item.media.m).appendTo(target_html_elem)
            )
          )
      this

    window.Application.animalCollection.each(addAnimalImageIfAppropriate, this)

  # add an animal as a sub-view
  addOneAnimalIfAppropriate: (animal) ->
    if animal.get('cage_id') == @model.id
      view = $("<li>" + animal.get('name') + '</li>')
      @$('.animal_list').append(view)
    this

  # add all animals as a sub-view
  addAllAnimals: ->
    window.Application.animalCollection.each(@addOneAnimalIfAppropriate, this)
    this

  updateElemCageContent: ->
    $(@el).html(window.UserCageView.template({
      model: @model.toJSON()
      entrances: {
        length: @model.entrances.length
      }
    }))

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

      null

#    @model.entrances.each(addEntranceToView, this)

    this

  # render this view
  render: ->
    if @marker == null
      markerPosition = new google.maps.LatLng(@model.get('latitude'), @model.get('longitude'))

      # be needing to create ze markersa! 
      @marker = new google.maps.Marker({
        map:@map
        animation: google.maps.Animation.DROP # When the marker initially comes into existence, drop it in place
        position: markerPosition
      })

      @updateElemCageContent()
      markerInfoWindowOptions = {
        content: @el
        #disableAutoPan: true
        disableAutoPan: false
        maxWidth: 0
        pixelOffset: new google.maps.Size(-140, 0)
        zIndex: null
        boxStyle: {
          background: "url('http://google-maps-utility-library-v3.googlecode.com/svn/trunk/infobox/examples/tipbox.gif') no-repeat"
          opacity: 0.95
          width: "170px"
        }
        closeBoxMargin: "6px 0px 0px 0px"
        closeBoxURL: "http://www.google.com/intl/en_us/mapfiles/close.gif"
        infoBoxClearance: new google.maps.Size(1, 1)
        isHidden: false
        pane: "floatPane"
        enableEventPropagation: false
      }
#      @markerInfoWindow = new google.maps.InfoWindow(markerInfoWindowOptions)
      @markerInfoWindow = new InfoBox(markerInfoWindowOptions)
      @markerInfoWindow.open(@map, @marker)
      @bringToFront()

      google.maps.event.addListener(@marker, 'click', =>
        @markerInfoWindow.open(@map, @marker)
        @bringToFront()
      )

    else

      markerPosition = new google.maps.LatLng(@model.get('latitude'), @model.get('longitude'))
      @marker.setPosition(markerPosition)
      @updateElemCageContent()
      @markerInfoWindow.setContent(@el)
      @markerInfoWindow.open(@map, @marker)
      @bringToFront()

    @marker.setTitle(@model.get('name'))
#    @addAllAnimals()
    if (@model.inAlarmState())
      @$el.addClass('error')
      @$el.removeClass('okay')
    else
      @$el.addClass('okay')
      @$el.removeClass('error')

    this

}, {
  lastZIndexUsed: 1

  # template for the Cage view
  template: _.template(
    '<div class="icons small_icons">' +
        '<img class="human_present" title="warning: human inside the cage" alt="human inside the cage icon" src="/assets/in_cage_icon.png"></img>' +
        '<img class="lights_on" title="light on in cage" alt="light on in cage icon" src="/assets/light_bulb_icon.png"></img>' +
    '</div>' +
    '<h1 class="cage_name"><%= model["name"] %></h1>'
  )
})
