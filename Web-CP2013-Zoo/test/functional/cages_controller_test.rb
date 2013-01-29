require 'test_helper'

class CagesControllerTest < ActionController::TestCase
  setup do
    @cage = cages(:one)
  end

  test "should get index" do
    get :index

    assert_response :success
    assert_not_nil assigns(:cages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cage" do
    assert_difference('Cage.count') do
      post :create, cage: { name: @cage.name, size: @cage.size, category: @cage.category, latitude: @cage.latitude, longitude: @cage.longitude, lights_on: @cage.lights_on, date_last_fed: @cage.date_last_fed, date_last_cleaned: @cage.date_last_cleaned }
    end

    assert_redirected_to cage_path(assigns(:cage))
  end

  test "should show cage" do
    get :show, id: @cage
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cage
    assert_response :success
  end

  test "should update cage" do
    put :update, id: @cage, cage: { name: @cage.name, size: @cage.size, category: @cage.category }
    assert_redirected_to cage_path(assigns(:cage))
  end

  test "should destroy cage" do
    assert_difference('Cage.count', -1) do
      delete :destroy, id: @cage
    end

    assert_redirected_to cages_path
  end

end
