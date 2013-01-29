require 'test_helper'

class CageTest < ActiveSupport::TestCase
  setup do
    @cage = cages(:one)
  end

  test "should be able to update size" do
    @cage.size = 31.4159
    assert @cage.save
  end

  test "should be able to update latitude" do
    @cage.latitude = 85.0
    assert @cage.save
  end

  test "should be able to update lights_on present" do
    @cage.lights_on = true
    assert @cage.save
  end

  test "should be able to update longitude" do
    @cage.longitude = 50.0
    assert @cage.save
  end

  test "should not save cage with negative size" do
    @cage.size = -1
    assert !@cage.save
  end

  test "should not save cage with size of 0" do
    @cage.size = 0
    assert !@cage.save
  end

  test "should be able to add an entrance" do
    assert_difference('Entrance.count') do
      new_entrance = @cage.entrances.create {}
    end
  end

  test "should be able to set name of cage" do
    @cage.name = "test name"
    assert @cage.save
  end

  test "should be able to save cage" do
    assert @cage.save
  end


  test "should be able to add an entrance with a door" do
    assert_difference('Entrance.count') do
      assert_difference('Door.count') do
        new_entrance = @cage.entrances.new {}
        new_door = new_entrance.doors.new {}

        @cage.save
      end
    end
  end

  test "test all attrs" do
    @cage.attributes.each_pair do |atrr_name, attr_value|
      CagesHelperTest::validate_attr(attr_value)
    end
  end

end
