require 'test_helper'

class TipoNormasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tipo_normas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tipo_norma" do
    assert_difference('TipoNorma.count') do
      post :create, :tipo_norma => { }
    end

    assert_redirected_to tipo_norma_path(assigns(:tipo_norma))
  end

  test "should show tipo_norma" do
    get :show, :id => tipo_normas(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => tipo_normas(:one).to_param
    assert_response :success
  end

  test "should update tipo_norma" do
    put :update, :id => tipo_normas(:one).to_param, :tipo_norma => { }
    assert_redirected_to tipo_norma_path(assigns(:tipo_norma))
  end

  test "should destroy tipo_norma" do
    assert_difference('TipoNorma.count', -1) do
      delete :destroy, :id => tipo_normas(:one).to_param
    end

    assert_redirected_to tipo_normas_path
  end
end
