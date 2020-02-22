require 'test_helper'

class NormasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @norma = normas(:one)
  end

  test "should get index" do
    get normas_url
    assert_response :success
  end

  test "should get new" do
    get new_norma_url
    assert_response :success
  end

  test "should create norma" do
    assert_difference('Norma.count') do
      post normas_url, params: { norma: { citas_doctorales: @norma.citas_doctorales, citas_jurisprudenciales: @norma.citas_jurisprudenciales, comentarios: @norma.comentarios, estado_id: @norma.estado_id, fecha_promulgacion: @norma.fecha_promulgacion, fecha_publicacion: @norma.fecha_publicacion, fecha_sancion: @norma.fecha_sancion, general: @norma.general, lugar_publicacion_id: @norma.lugar_publicacion_id, numero: @norma.numero, sumario: @norma.sumario, texto: @norma.texto, tipo_norma_id: @norma.tipo_norma_id } }
    end

    assert_redirected_to norma_url(Norma.last)
  end

  test "should show norma" do
    get norma_url(@norma)
    assert_response :success
  end

  test "should get edit" do
    get edit_norma_url(@norma)
    assert_response :success
  end

  test "should update norma" do
    patch norma_url(@norma), params: { norma: { citas_doctorales: @norma.citas_doctorales, citas_jurisprudenciales: @norma.citas_jurisprudenciales, comentarios: @norma.comentarios, estado_id: @norma.estado_id, fecha_promulgacion: @norma.fecha_promulgacion, fecha_publicacion: @norma.fecha_publicacion, fecha_sancion: @norma.fecha_sancion, general: @norma.general, lugar_publicacion_id: @norma.lugar_publicacion_id, numero: @norma.numero, sumario: @norma.sumario, texto: @norma.texto, tipo_norma_id: @norma.tipo_norma_id } }
    assert_redirected_to norma_url(@norma)
  end

  test "should destroy norma" do
    assert_difference('Norma.count', -1) do
      delete norma_url(@norma)
    end

    assert_redirected_to normas_url
  end
end
