require 'test_helper'

class EntranceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @entrance = entrances(:one)
    @cage = @entrance.cage
  end

  test "entrance is open if any of the doors are open" do
    my_entrance = Entrance.new()
    open_door = Door.new({ open: true})
    closed_door = Door.new({ open: false})

    my_entrance.doors << open_door
    my_entrance.doors << closed_door

    assert my_entrance.save()
    assert my_entrance.open?
  end

  test "entrance is closed if all of the doors are closed" do
    my_entrance = Entrance.new()
    closed_door = Door.new({ open: false})
    my_entrance.doors << closed_door

    assert my_entrance.save()
    assert !my_entrance.open?
  end

end
