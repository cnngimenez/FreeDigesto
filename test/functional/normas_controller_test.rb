require 'test_helper'

class NormasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:normas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create norma" do
    assert_difference('Norma.count') do
      post :create, :norma => { }
    end

    assert_redirected_to norma_path(assigns(:norma))
  end

  test "should show norma" do
    get :show, :id => normas(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => normas(:one).to_param
    assert_response :success
  end

  test "should update norma" do
    put :update, :id => normas(:one).to_param, :norma => { }
    assert_redirected_to norma_path(assigns(:norma))
  end

  test "should destroy norma" do
    assert_difference('Norma.count', -1) do
      delete :destroy, :id => normas(:one).to_param
    end

    assert_redirected_to normas_path
  end
end
