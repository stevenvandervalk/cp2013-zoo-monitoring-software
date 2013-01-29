require 'test_helper'

class DoorTest < ActiveSupport::TestCase
  setup do
    @open_door = doors(:open_door)
    @closed_door = doors(:closed_door)
  end

  test "check if a door is open" do
    assert @open_door.open
  end

  test "check if a door is closed" do
    assert !@closed_door.open
  end

end
