require 'test_helper'

class PatronPrivilegiosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:patron_privilegios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create patron_privilegio" do
    assert_difference('PatronPrivilegio.count') do
      post :create, :patron_privilegio => { }
    end

    assert_redirected_to patron_privilegio_path(assigns(:patron_privilegio))
  end

  test "should show patron_privilegio" do
    get :show, :id => patron_privilegios(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => patron_privilegios(:one).to_param
    assert_response :success
  end

  test "should update patron_privilegio" do
    put :update, :id => patron_privilegios(:one).to_param, :patron_privilegio => { }
    assert_redirected_to patron_privilegio_path(assigns(:patron_privilegio))
  end

  test "should destroy patron_privilegio" do
    assert_difference('PatronPrivilegio.count', -1) do
      delete :destroy, :id => patron_privilegios(:one).to_param
    end

    assert_redirected_to patron_privilegios_path
  end
end
