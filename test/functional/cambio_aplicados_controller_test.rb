require 'test_helper'

class CambioAplicadosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cambio_aplicados)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cambio_aplicado" do
    assert_difference('CambioAplicado.count') do
      post :create, :cambio_aplicado => { }
    end

    assert_redirected_to cambio_aplicado_path(assigns(:cambio_aplicado))
  end

  test "should show cambio_aplicado" do
    get :show, :id => cambio_aplicados(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => cambio_aplicados(:one).to_param
    assert_response :success
  end

  test "should update cambio_aplicado" do
    put :update, :id => cambio_aplicados(:one).to_param, :cambio_aplicado => { }
    assert_redirected_to cambio_aplicado_path(assigns(:cambio_aplicado))
  end

  test "should destroy cambio_aplicado" do
    assert_difference('CambioAplicado.count', -1) do
      delete :destroy, :id => cambio_aplicados(:one).to_param
    end

    assert_redirected_to cambio_aplicados_path
  end
end
