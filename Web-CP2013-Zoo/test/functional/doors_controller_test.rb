require 'test_helper'

class DoorsControllerTest < ActionController::TestCase
  setup do
    @door = doors(:open_door)
    @entrance = @door.entrance
    @cage = @entrance.cage
  end

  test "should get index" do
    get :index, cage_id: @cage, entrance_id: @entrance

    assert_response :success
    assert_not_nil assigns(:doors)
  end

  test "should get new" do
    get :new, cage_id: @cage, entrance_id: @entrance
    assert_response :success
  end

  test "should create door" do
    assert_difference('Door.count') do
      post :create, cage_id: @cage, entrance_id: @entrance, door: { open: @door.open }
    end

    assert_redirected_to cage_entrance_door_path(@cage, @entrance, assigns(:door))
  end

  test "should show door" do
    get :show, cage_id: @cage, entrance_id: @entrance, id: @door
    assert_response :success
  end

  test "should get edit" do
    get :edit, cage_id: @cage, entrance_id: @entrance, id: @door
    assert_response :success
  end

  test "should update door" do
    put :update, cage_id: @cage, entrance_id: @entrance, id: @door, door: { open: @door.open }
    assert_redirected_to cage_entrance_door_path(@cage, @entrance, assigns(:door))
  end

  test "should destroy door" do
    assert_difference('Door.count', -1) do
      delete :destroy, cage_id: @cage, entrance_id: @entrance, id: @door
    end

    assert_redirected_to cage_entrance_doors_path(@cage, @entrance)
  end

end
