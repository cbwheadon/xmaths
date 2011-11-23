require 'test_helper'

class QResponsesControllerTest < ActionController::TestCase
  setup do
    @q_response = q_responses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:q_responses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create q_response" do
    assert_difference('QResponse.count') do
      post :create, q_response: @q_response.attributes
    end

    assert_redirected_to q_response_path(assigns(:q_response))
  end

  test "should show q_response" do
    get :show, id: @q_response.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @q_response.to_param
    assert_response :success
  end

  test "should update q_response" do
    put :update, id: @q_response.to_param, q_response: @q_response.attributes
    assert_redirected_to q_response_path(assigns(:q_response))
  end

  test "should destroy q_response" do
    assert_difference('QResponse.count', -1) do
      delete :destroy, id: @q_response.to_param
    end

    assert_redirected_to q_responses_path
  end
end
