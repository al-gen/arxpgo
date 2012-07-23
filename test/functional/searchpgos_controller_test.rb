require 'test_helper'

class SearchpgosControllerTest < ActionController::TestCase
  setup do
    @searchpgo = searchpgos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:searchpgos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create searchpgo" do
    assert_difference('Searchpgo.count') do
      post :create, searchpgo: @searchpgo.attributes
    end

    assert_redirected_to searchpgo_path(assigns(:searchpgo))
  end

  test "should show searchpgo" do
    get :show, id: @searchpgo.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @searchpgo.to_param
    assert_response :success
  end

  test "should update searchpgo" do
    put :update, id: @searchpgo.to_param, searchpgo: @searchpgo.attributes
    assert_redirected_to searchpgo_path(assigns(:searchpgo))
  end

  test "should destroy searchpgo" do
    assert_difference('Searchpgo.count', -1) do
      delete :destroy, id: @searchpgo.to_param
    end

    assert_redirected_to searchpgos_path
  end
end
