require 'test_helper'

class LugarPublicacionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lugar_publicacion = lugar_publicacions(:one)
  end

  test "should get index" do
    get lugar_publicacions_url
    assert_response :success
  end

  test "should get new" do
    get new_lugar_publicacion_url
    assert_response :success
  end

  test "should create lugar_publicacion" do
    assert_difference('LugarPublicacion.count') do
      post lugar_publicacions_url, params: { lugar_publicacion: { comentario: @lugar_publicacion.comentario, nombre: @lugar_publicacion.nombre } }
    end

    assert_redirected_to lugar_publicacion_url(LugarPublicacion.last)
  end

  test "should show lugar_publicacion" do
    get lugar_publicacion_url(@lugar_publicacion)
    assert_response :success
  end

  test "should get edit" do
    get edit_lugar_publicacion_url(@lugar_publicacion)
    assert_response :success
  end

  test "should update lugar_publicacion" do
    patch lugar_publicacion_url(@lugar_publicacion), params: { lugar_publicacion: { comentario: @lugar_publicacion.comentario, nombre: @lugar_publicacion.nombre } }
    assert_redirected_to lugar_publicacion_url(@lugar_publicacion)
  end

  test "should destroy lugar_publicacion" do
    assert_difference('LugarPublicacion.count', -1) do
      delete lugar_publicacion_url(@lugar_publicacion)
    end

    assert_redirected_to lugar_publicacions_url
  end
end
