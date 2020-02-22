require 'test_helper'

class TienePrivilegiosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tiene_privilegio = tiene_privilegios(:one)
  end

  test "should get index" do
    get tiene_privilegios_url
    assert_response :success
  end

  test "should get new" do
    get new_tiene_privilegio_url
    assert_response :success
  end

  test "should create tiene_privilegio" do
    assert_difference('TienePrivilegio.count') do
      post tiene_privilegios_url, params: { tiene_privilegio: { privilegio_id: @tiene_privilegio.privilegio_id, usuario_id: @tiene_privilegio.usuario_id } }
    end

    assert_redirected_to tiene_privilegio_url(TienePrivilegio.last)
  end

  test "should show tiene_privilegio" do
    get tiene_privilegio_url(@tiene_privilegio)
    assert_response :success
  end

  test "should get edit" do
    get edit_tiene_privilegio_url(@tiene_privilegio)
    assert_response :success
  end

  test "should update tiene_privilegio" do
    patch tiene_privilegio_url(@tiene_privilegio), params: { tiene_privilegio: { privilegio_id: @tiene_privilegio.privilegio_id, usuario_id: @tiene_privilegio.usuario_id } }
    assert_redirected_to tiene_privilegio_url(@tiene_privilegio)
  end

  test "should destroy tiene_privilegio" do
    assert_difference('TienePrivilegio.count', -1) do
      delete tiene_privilegio_url(@tiene_privilegio)
    end

    assert_redirected_to tiene_privilegios_url
  end
end
