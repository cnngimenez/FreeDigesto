require 'test_helper'

class TienePrivilegiosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tiene_privilegios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tiene_privilegio" do
    assert_difference('TienePrivilegio.count') do
      post :create, :tiene_privilegio => { }
    end

    assert_redirected_to tiene_privilegio_path(assigns(:tiene_privilegio))
  end

  test "should show tiene_privilegio" do
    get :show, :id => tiene_privilegios(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => tiene_privilegios(:one).to_param
    assert_response :success
  end

  test "should update tiene_privilegio" do
    put :update, :id => tiene_privilegios(:one).to_param, :tiene_privilegio => { }
    assert_redirected_to tiene_privilegio_path(assigns(:tiene_privilegio))
  end

  test "should destroy tiene_privilegio" do
    assert_difference('TienePrivilegio.count', -1) do
      delete :destroy, :id => tiene_privilegios(:one).to_param
    end

    assert_redirected_to tiene_privilegios_path
  end
end
