require 'test_helper'

class AgregarPrivilegiosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @agregar_privilegio = agregar_privilegios(:one)
  end

  test "should get index" do
    get agregar_privilegios_url
    assert_response :success
  end

  test "should get new" do
    get new_agregar_privilegio_url
    assert_response :success
  end

  test "should create agregar_privilegio" do
    assert_difference('AgregarPrivilegio.count') do
      post agregar_privilegios_url, params: { agregar_privilegio: { Patron_privilegio_id: @agregar_privilegio.Patron_privilegio_id, Privilegio_id: @agregar_privilegio.Privilegio_id } }
    end

    assert_redirected_to agregar_privilegio_url(AgregarPrivilegio.last)
  end

  test "should show agregar_privilegio" do
    get agregar_privilegio_url(@agregar_privilegio)
    assert_response :success
  end

  test "should get edit" do
    get edit_agregar_privilegio_url(@agregar_privilegio)
    assert_response :success
  end

  test "should update agregar_privilegio" do
    patch agregar_privilegio_url(@agregar_privilegio), params: { agregar_privilegio: { Patron_privilegio_id: @agregar_privilegio.Patron_privilegio_id, Privilegio_id: @agregar_privilegio.Privilegio_id } }
    assert_redirected_to agregar_privilegio_url(@agregar_privilegio)
  end

  test "should destroy agregar_privilegio" do
    assert_difference('AgregarPrivilegio.count', -1) do
      delete agregar_privilegio_url(@agregar_privilegio)
    end

    assert_redirected_to agregar_privilegios_url
  end
end
