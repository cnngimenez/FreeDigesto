require 'test_helper'

class CambioEstadosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cambio_estado = cambio_estados(:one)
  end

  test "should get index" do
    get cambio_estados_url
    assert_response :success
  end

  test "should get new" do
    get new_cambio_estado_url
    assert_response :success
  end

  test "should create cambio_estado" do
    assert_difference('CambioEstado.count') do
      post cambio_estados_url, params: { cambio_estado: { causa_cambio_estado_id: @cambio_estado.causa_cambio_estado_id, comentario: @cambio_estado.comentario, estado_id: @cambio_estado.estado_id, fecha_cambio: @cambio_estado.fecha_cambio, fecha_creacion: @cambio_estado.fecha_creacion, norma_id: @cambio_estado.norma_id } }
    end

    assert_redirected_to cambio_estado_url(CambioEstado.last)
  end

  test "should show cambio_estado" do
    get cambio_estado_url(@cambio_estado)
    assert_response :success
  end

  test "should get edit" do
    get edit_cambio_estado_url(@cambio_estado)
    assert_response :success
  end

  test "should update cambio_estado" do
    patch cambio_estado_url(@cambio_estado), params: { cambio_estado: { causa_cambio_estado_id: @cambio_estado.causa_cambio_estado_id, comentario: @cambio_estado.comentario, estado_id: @cambio_estado.estado_id, fecha_cambio: @cambio_estado.fecha_cambio, fecha_creacion: @cambio_estado.fecha_creacion, norma_id: @cambio_estado.norma_id } }
    assert_redirected_to cambio_estado_url(@cambio_estado)
  end

  test "should destroy cambio_estado" do
    assert_difference('CambioEstado.count', -1) do
      delete cambio_estado_url(@cambio_estado)
    end

    assert_redirected_to cambio_estados_url
  end
end
