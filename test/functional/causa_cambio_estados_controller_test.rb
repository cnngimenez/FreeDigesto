require 'test_helper'

class CausaCambioEstadosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:causa_cambio_estados)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create causa_cambio_estado" do
    assert_difference('CausaCambioEstado.count') do
      post :create, :causa_cambio_estado => { }
    end

    assert_redirected_to causa_cambio_estado_path(assigns(:causa_cambio_estado))
  end

  test "should show causa_cambio_estado" do
    get :show, :id => causa_cambio_estados(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => causa_cambio_estados(:one).to_param
    assert_response :success
  end

  test "should update causa_cambio_estado" do
    put :update, :id => causa_cambio_estados(:one).to_param, :causa_cambio_estado => { }
    assert_redirected_to causa_cambio_estado_path(assigns(:causa_cambio_estado))
  end

  test "should destroy causa_cambio_estado" do
    assert_difference('CausaCambioEstado.count', -1) do
      delete :destroy, :id => causa_cambio_estados(:one).to_param
    end

    assert_redirected_to causa_cambio_estados_path
  end
end
