require 'test_helper'

class CambioEstadosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cambio_estados)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cambio_estado" do
    assert_difference('CambioEstado.count') do
      post :create, :cambio_estado => { }
    end

    assert_redirected_to cambio_estado_path(assigns(:cambio_estado))
  end

  test "should show cambio_estado" do
    get :show, :id => cambio_estados(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => cambio_estados(:one).to_param
    assert_response :success
  end

  test "should update cambio_estado" do
    put :update, :id => cambio_estados(:one).to_param, :cambio_estado => { }
    assert_redirected_to cambio_estado_path(assigns(:cambio_estado))
  end

  test "should destroy cambio_estado" do
    assert_difference('CambioEstado.count', -1) do
      delete :destroy, :id => cambio_estados(:one).to_param
    end

    assert_redirected_to cambio_estados_path
  end
end
