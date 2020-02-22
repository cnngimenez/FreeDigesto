require 'test_helper'

class PrivilegiosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @privilegio = privilegios(:one)
  end

  test "should get index" do
    get privilegios_url
    assert_response :success
  end

  test "should get new" do
    get new_privilegio_url
    assert_response :success
  end

  test "should create privilegio" do
    assert_difference('Privilegio.count') do
      post privilegios_url, params: { privilegio: { comentario: @privilegio.comentario, nombre: @privilegio.nombre } }
    end

    assert_redirected_to privilegio_url(Privilegio.last)
  end

  test "should show privilegio" do
    get privilegio_url(@privilegio)
    assert_response :success
  end

  test "should get edit" do
    get edit_privilegio_url(@privilegio)
    assert_response :success
  end

  test "should update privilegio" do
    patch privilegio_url(@privilegio), params: { privilegio: { comentario: @privilegio.comentario, nombre: @privilegio.nombre } }
    assert_redirected_to privilegio_url(@privilegio)
  end

  test "should destroy privilegio" do
    assert_difference('Privilegio.count', -1) do
      delete privilegio_url(@privilegio)
    end

    assert_redirected_to privilegios_url
  end
end
