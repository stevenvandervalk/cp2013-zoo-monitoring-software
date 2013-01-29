# The Admin Application View
window.AdminApplicationView = Backbone.View.extend({

  # View represents a div
  tagName:  "div"

  # View should handle the following events
  events: {
    "click #add_cage": "addCage"
    "click #change_cage_count": "updateCageCount"
    "click #clear_cages": "clearCages"

    "click #add_employee": "addEmployee"
    "click #change_employee_count": "updateEmployeeCount"
    "click #clear_employees": "clearEmployees"

    "click #add_animal": "addAnimal"
    "click #change_animal_count": "updateAnimalCount"
    "click #clear_animals": "clearAnimals"
  }

  # Store a reference to the associated cage collection
  initialize: (options) ->
    @cageCollection = options.cageCollection
    @cageCollection.bind('reset', @addAllCages, this)
    @cageCollection.bind('add', @addOneCage, this)

    @employeeCollection = options.employeeCollection
    @employeeCollection.bind('reset', @addAllEmployees, this)
    @employeeCollection.bind('add', @addOneEmployee, this)

    @animalCollection = options.animalCollection
    @animalCollection.bind('reset', @addAllAnimals, this)
    @animalCollection.bind('add', @addOneAnimal, this)

    this

  # Add a cage to the cage collection
  addCage: ->
    @cageCollection.create()
    null

  # Add a cage to the view
  addOneCage: (cage) ->
    view = new window.Views['cage']({model: cage})
    $("#cages_list > tbody").append(view.render().el)
    null

  # Add all cages from the cage collection to the view 
  addAllCages: ->
    @cageCollection.each(@addOneCage);
    null

  # Delete all cages
  clearCages: ->
    while (@cageCollection.length > 0)
      @cageCollection.at(0).destroy()
    $('#cage_count').val("")
    null

  # Update the number of cages based on the value in #cage_count
  # Alerts if cage_count is invalid (valid range: 1 - 100 inclusive)
  updateCageCount: ->
    targetCount = parseInt($('#cage_count').val())
    # If the input is a valid number within the expected rangek
    if !isNaN(targetCount) and targetCount >= 0 and targetCount <= 100
      # Remove cages if too many
      while (@cageCollection.length > targetCount)
        @cageCollection.at(0).destroy()

      # Add cages if too few
      while (@cageCollection.length < targetCount)
        @addCage()
    else
      # Invalid input
      alert "Invalid input cage count. Needs to be a value of 0 to 100 (inclusive)."

  # Add an animal to the animal collection
  addAnimal: ->
    @animalCollection.create()
    null

  # Add an animal to the view
  addOneAnimal: (animal) ->
    view = new window.Views['animal']({model: animal})
    $("#animals_list > tbody").append(view.render().el)
    null


  # Add all animals from the animal collection to the view 
  addAllAnimals: ->
    @animalCollection.each(@addOneAnimal);
    null

  # Delete all animals
  clearAnimals: ->
    while (@animalCollection.length > 0)
      @animalCollection.at(0).destroy()
    $('#animal_count').val("")
    null

  # Update the number of animals based on the value in #animal_count
  # Alerts if animal_count is invalid (valid range: 1 - 100 inclusive)
  updateAnimalCount: ->
    targetCount = parseInt($('#animal_count').val())
    # If the input is a valid number within the expected range
    if !isNaN(targetCount) and targetCount >= 0 and targetCount <= 100
      # Remove animals if too many
      while (@animalCollection.length > targetCount)
        @animalCollection.at(0).destroy()

      # Add animal if too few
      while (@animalCollection.length < targetCount)
        @addAnimal()
    else
      # Invalid input
      alert "Invalid input animal count. Needs to be a value of 0 to 100 (inclusive)."

  # Add an employee to the employee collection
  addEmployee: ->
    @employeeCollection.create()
    null

  # Add an employee to the view
  addOneEmployee: (employee) ->
    view = new window.Views['employee']({model: employee})
    $("#employees_list > tbody").append(view.render().el)
    null

  # Add all employees from the employee collection to the view 
  addAllEmployees: ->
    @employeeCollection.each(@addOneEmployee);
    null

  # Delete all employees
  clearEmployees: ->
    while (@employeeCollection.length > 0)
      @employeeCollection.at(0).destroy()
    $('#employee_count').val("")
    null

  # Update the number of employees based on the value in #employee_count
  # Alerts if employee_count is invalid (valid range: 1 - 100 inclusive)
  updateEmployeeCount: ->
    targetCount = parseInt($('#employee_count').val())
    # If the input is a valid number within the expected rangek
    if !isNaN(targetCount) and targetCount >= 0 and targetCount <= 100
      # Remove employees if too many
      while (@employeeCollection.length > targetCount)
        @employeeCollection.at(0).destroy()

      # Add employees if too few
      while (@employeeCollection.length < targetCount)
        @addEmployee()
    else
      # Invalid input
      alert "Invalid input employee count. Needs to be a value of 0 to 100 (inclusive)."
})
