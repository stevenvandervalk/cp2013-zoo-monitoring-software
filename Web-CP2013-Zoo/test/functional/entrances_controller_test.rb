require 'test_helper'

class EntrancesControllerTest < ActionController::TestCase
  setup do
    @entrance = entrances(:one)
    @cage = @entrance.cage
  end

  test "should get index" do
    get :index, cage_id: @cage

    assert_response :success
    assert_not_nil assigns(:entrances)
  end

  test "should get new" do
    get :new, cage_id: @cage, entrance_id: @entrance
    assert_response :success
  end

  test "should create entrance" do
    assert_difference('Entrance.count') do
      post :create, cage_id: @cage, entrance_id: @entrance, entrance: { }
    end

    assert_redirected_to cage_entrance_path(@cage, assigns(:entrance))
  end

  test "should show entrance" do
    get :show, cage_id: @cage, id: @entrance
    assert_response :success
  end

  test "should get edit" do
    get :edit, cage_id: @cage, id: @entrance
    assert_response :success
  end

  test "should update entrance" do
    put :update, cage_id: @cage, id: @entrance, entrance: { }
    assert_redirected_to cage_entrance_path(@cage, assigns(:entrance))
  end

  test "should destroy entrance" do
    assert_difference('Entrance.count', -1) do
      delete :destroy, cage_id: @cage, id: @entrance
    end

    assert_redirected_to cage_entrances_path(@cage)
  end

end
