require 'test_helper'

class PatronPrivilegiosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @patron_privilegio = patron_privilegios(:one)
  end

  test "should get index" do
    get patron_privilegios_url
    assert_response :success
  end

  test "should get new" do
    get new_patron_privilegio_url
    assert_response :success
  end

  test "should create patron_privilegio" do
    assert_difference('PatronPrivilegio.count') do
      post patron_privilegios_url, params: { patron_privilegio: { comentario: @patron_privilegio.comentario, nombre: @patron_privilegio.nombre } }
    end

    assert_redirected_to patron_privilegio_url(PatronPrivilegio.last)
  end

  test "should show patron_privilegio" do
    get patron_privilegio_url(@patron_privilegio)
    assert_response :success
  end

  test "should get edit" do
    get edit_patron_privilegio_url(@patron_privilegio)
    assert_response :success
  end

  test "should update patron_privilegio" do
    patch patron_privilegio_url(@patron_privilegio), params: { patron_privilegio: { comentario: @patron_privilegio.comentario, nombre: @patron_privilegio.nombre } }
    assert_redirected_to patron_privilegio_url(@patron_privilegio)
  end

  test "should destroy patron_privilegio" do
    assert_difference('PatronPrivilegio.count', -1) do
      delete patron_privilegio_url(@patron_privilegio)
    end

    assert_redirected_to patron_privilegios_url
  end
end
