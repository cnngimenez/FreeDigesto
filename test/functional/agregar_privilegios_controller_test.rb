require 'test_helper'

class AgregarPrivilegiosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:agregar_privilegios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create agregar_privilegio" do
    assert_difference('AgregarPrivilegio.count') do
      post :create, :agregar_privilegio => { }
    end

    assert_redirected_to agregar_privilegio_path(assigns(:agregar_privilegio))
  end

  test "should show agregar_privilegio" do
    get :show, :id => agregar_privilegios(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => agregar_privilegios(:one).to_param
    assert_response :success
  end

  test "should update agregar_privilegio" do
    put :update, :id => agregar_privilegios(:one).to_param, :agregar_privilegio => { }
    assert_redirected_to agregar_privilegio_path(assigns(:agregar_privilegio))
  end

  test "should destroy agregar_privilegio" do
    assert_difference('AgregarPrivilegio.count', -1) do
      delete :destroy, :id => agregar_privilegios(:one).to_param
    end

    assert_redirected_to agregar_privilegios_path
  end
end
