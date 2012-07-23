require 'test_helper'

class RadasControllerTest < ActionController::TestCase
  setup do
    @rada = radas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:radas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rada" do
    assert_difference('Rada.count') do
      post :create, rada: @rada.attributes
    end

    assert_redirected_to rada_path(assigns(:rada))
  end

  test "should show rada" do
    get :show, id: @rada.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rada.to_param
    assert_response :success
  end

  test "should update rada" do
    put :update, id: @rada.to_param, rada: @rada.attributes
    assert_redirected_to rada_path(assigns(:rada))
  end

  test "should destroy rada" do
    assert_difference('Rada.count', -1) do
      delete :destroy, id: @rada.to_param
    end

    assert_redirected_to radas_path
  end
end
