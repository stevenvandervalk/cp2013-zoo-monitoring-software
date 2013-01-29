require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  setup do
    @message = messages(:one)
    @employee = @message.employee
  end

  test "should get index" do
    get :index, employee_id: @employee
    assert_response :success
    assert_not_nil assigns(:messages)
  end

  test "should get new" do
    get :new, employee_id: @employee, message_id: @message
    assert_response :success
  end

  test "should create message" do
    assert_difference('Message.count') do
      post :create, employee_id: @employee, message: { message: @message.message }
    end

    assert_redirected_to employee_message_path(@employee, assigns(:message))
  end

  test "should show message" do
    get :show, employee_id: @employee, id: @message
    assert_response :success
  end

  test "should get edit" do
    get :edit, employee_id: @employee, id: @message
    assert_response :success
  end

  test "should update message" do
    put :update, employee_id: @employee, id: @message, message: { message: @message.message }
    assert_redirected_to employee_message_path(@employee, assigns(:message))
  end

  test "should destroy message" do
    assert_difference('Message.count', -1) do
      delete :destroy, employee_id: @employee, id: @message
    end

    assert_redirected_to employee_messages_path(@employee)
  end
end
