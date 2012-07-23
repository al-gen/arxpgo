require 'test_helper'

class PgosControllerTest < ActionController::TestCase
  setup do
    @pgo = pgos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pgos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pgo" do
    assert_difference('Pgo.count') do
      post :create, pgo: @pgo.attributes
    end

    assert_redirected_to pgo_path(assigns(:pgo))
  end

  test "should show pgo" do
    get :show, id: @pgo.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pgo.to_param
    assert_response :success
  end

  test "should update pgo" do
    put :update, id: @pgo.to_param, pgo: @pgo.attributes
    assert_redirected_to pgo_path(assigns(:pgo))
  end

  test "should destroy pgo" do
    assert_difference('Pgo.count', -1) do
      delete :destroy, id: @pgo.to_param
    end

    assert_redirected_to pgos_path
  end
end
