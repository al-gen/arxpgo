require 'test_helper'

class ArxivsControllerTest < ActionController::TestCase
  setup do
    @arxiv = arxivs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:arxivs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create arxiv" do
    assert_difference('Arxiv.count') do
      post :create, arxiv: @arxiv.attributes
    end

    assert_redirected_to arxiv_path(assigns(:arxiv))
  end

  test "should show arxiv" do
    get :show, id: @arxiv.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @arxiv.to_param
    assert_response :success
  end

  test "should update arxiv" do
    put :update, id: @arxiv.to_param, arxiv: @arxiv.attributes
    assert_redirected_to arxiv_path(assigns(:arxiv))
  end

  test "should destroy arxiv" do
    assert_difference('Arxiv.count', -1) do
      delete :destroy, id: @arxiv.to_param
    end

    assert_redirected_to arxivs_path
  end
end
