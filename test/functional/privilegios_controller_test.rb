require 'test_helper'

class PrivilegiosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:privilegios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create privilegio" do
    assert_difference('Privilegio.count') do
      post :create, :privilegio => { }
    end

    assert_redirected_to privilegio_path(assigns(:privilegio))
  end

  test "should show privilegio" do
    get :show, :id => privilegios(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => privilegios(:one).to_param
    assert_response :success
  end

  test "should update privilegio" do
    put :update, :id => privilegios(:one).to_param, :privilegio => { }
    assert_redirected_to privilegio_path(assigns(:privilegio))
  end

  test "should destroy privilegio" do
    assert_difference('Privilegio.count', -1) do
      delete :destroy, :id => privilegios(:one).to_param
    end

    assert_redirected_to privilegios_path
  end
end
