require 'test_helper'

class PlaygroundsControllerTest < ActionController::TestCase
  setup do
    @playground = playgrounds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:playgrounds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create playground" do
    assert_difference('Playground.count') do
      post :create, playground: @playground.attributes
    end

    assert_redirected_to playground_path(assigns(:playground))
  end

  test "should show playground" do
    get :show, id: @playground.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @playground.to_param
    assert_response :success
  end

  test "should update playground" do
    put :update, id: @playground.to_param, playground: @playground.attributes
    assert_redirected_to playground_path(assigns(:playground))
  end

  test "should destroy playground" do
    assert_difference('Playground.count', -1) do
      delete :destroy, id: @playground.to_param
    end

    assert_redirected_to playgrounds_path
  end
end
