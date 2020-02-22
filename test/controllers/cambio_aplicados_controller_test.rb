require 'test_helper'

class CambioAplicadosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cambio_aplicado = cambio_aplicados(:one)
  end

  test "should get index" do
    get cambio_aplicados_url
    assert_response :success
  end

  test "should get new" do
    get new_cambio_aplicado_url
    assert_response :success
  end

  test "should create cambio_aplicado" do
    assert_difference('CambioAplicado.count') do
      post cambio_aplicados_url, params: { cambio_aplicado: { cambio_estado_id: @cambio_aplicado.cambio_estado_id, comentario: @cambio_aplicado.comentario, fecha_aplicado: @cambio_aplicado.fecha_aplicado } }
    end

    assert_redirected_to cambio_aplicado_url(CambioAplicado.last)
  end

  test "should show cambio_aplicado" do
    get cambio_aplicado_url(@cambio_aplicado)
    assert_response :success
  end

  test "should get edit" do
    get edit_cambio_aplicado_url(@cambio_aplicado)
    assert_response :success
  end

  test "should update cambio_aplicado" do
    patch cambio_aplicado_url(@cambio_aplicado), params: { cambio_aplicado: { cambio_estado_id: @cambio_aplicado.cambio_estado_id, comentario: @cambio_aplicado.comentario, fecha_aplicado: @cambio_aplicado.fecha_aplicado } }
    assert_redirected_to cambio_aplicado_url(@cambio_aplicado)
  end

  test "should destroy cambio_aplicado" do
    assert_difference('CambioAplicado.count', -1) do
      delete cambio_aplicado_url(@cambio_aplicado)
    end

    assert_redirected_to cambio_aplicados_url
  end
end
