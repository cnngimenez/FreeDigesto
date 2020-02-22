require 'test_helper'

class CausaCambioEstadosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @causa_cambio_estado = causa_cambio_estados(:one)
  end

  test "should get index" do
    get causa_cambio_estados_url
    assert_response :success
  end

  test "should get new" do
    get new_causa_cambio_estado_url
    assert_response :success
  end

  test "should create causa_cambio_estado" do
    assert_difference('CausaCambioEstado.count') do
      post causa_cambio_estados_url, params: { causa_cambio_estado: { comentario: @causa_cambio_estado.comentario, nombre: @causa_cambio_estado.nombre } }
    end

    assert_redirected_to causa_cambio_estado_url(CausaCambioEstado.last)
  end

  test "should show causa_cambio_estado" do
    get causa_cambio_estado_url(@causa_cambio_estado)
    assert_response :success
  end

  test "should get edit" do
    get edit_causa_cambio_estado_url(@causa_cambio_estado)
    assert_response :success
  end

  test "should update causa_cambio_estado" do
    patch causa_cambio_estado_url(@causa_cambio_estado), params: { causa_cambio_estado: { comentario: @causa_cambio_estado.comentario, nombre: @causa_cambio_estado.nombre } }
    assert_redirected_to causa_cambio_estado_url(@causa_cambio_estado)
  end

  test "should destroy causa_cambio_estado" do
    assert_difference('CausaCambioEstado.count', -1) do
      delete causa_cambio_estado_url(@causa_cambio_estado)
    end

    assert_redirected_to causa_cambio_estados_url
  end
end
