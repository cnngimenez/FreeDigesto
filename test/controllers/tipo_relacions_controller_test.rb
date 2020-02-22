require 'test_helper'

class TipoRelacionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tipo_relacion = tipo_relacions(:one)
  end

  test "should get index" do
    get tipo_relacions_url
    assert_response :success
  end

  test "should get new" do
    get new_tipo_relacion_url
    assert_response :success
  end

  test "should create tipo_relacion" do
    assert_difference('TipoRelacion.count') do
      post tipo_relacions_url, params: { tipo_relacion: { comentario: @tipo_relacion.comentario, nombre: @tipo_relacion.nombre } }
    end

    assert_redirected_to tipo_relacion_url(TipoRelacion.last)
  end

  test "should show tipo_relacion" do
    get tipo_relacion_url(@tipo_relacion)
    assert_response :success
  end

  test "should get edit" do
    get edit_tipo_relacion_url(@tipo_relacion)
    assert_response :success
  end

  test "should update tipo_relacion" do
    patch tipo_relacion_url(@tipo_relacion), params: { tipo_relacion: { comentario: @tipo_relacion.comentario, nombre: @tipo_relacion.nombre } }
    assert_redirected_to tipo_relacion_url(@tipo_relacion)
  end

  test "should destroy tipo_relacion" do
    assert_difference('TipoRelacion.count', -1) do
      delete tipo_relacion_url(@tipo_relacion)
    end

    assert_redirected_to tipo_relacions_url
  end
end
