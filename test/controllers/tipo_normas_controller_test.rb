require 'test_helper'

class TipoNormasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tipo_norma = tipo_normas(:one)
  end

  test "should get index" do
    get tipo_normas_url
    assert_response :success
  end

  test "should get new" do
    get new_tipo_norma_url
    assert_response :success
  end

  test "should create tipo_norma" do
    assert_difference('TipoNorma.count') do
      post tipo_normas_url, params: { tipo_norma: { comentario: @tipo_norma.comentario, nombre: @tipo_norma.nombre } }
    end

    assert_redirected_to tipo_norma_url(TipoNorma.last)
  end

  test "should show tipo_norma" do
    get tipo_norma_url(@tipo_norma)
    assert_response :success
  end

  test "should get edit" do
    get edit_tipo_norma_url(@tipo_norma)
    assert_response :success
  end

  test "should update tipo_norma" do
    patch tipo_norma_url(@tipo_norma), params: { tipo_norma: { comentario: @tipo_norma.comentario, nombre: @tipo_norma.nombre } }
    assert_redirected_to tipo_norma_url(@tipo_norma)
  end

  test "should destroy tipo_norma" do
    assert_difference('TipoNorma.count', -1) do
      delete tipo_norma_url(@tipo_norma)
    end

    assert_redirected_to tipo_normas_url
  end
end
