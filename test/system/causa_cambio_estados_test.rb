require "application_system_test_case"

class CausaCambioEstadosTest < ApplicationSystemTestCase
  setup do
    @causa_cambio_estado = causa_cambio_estados(:one)
  end

  test "visiting the index" do
    visit causa_cambio_estados_url
    assert_selector "h1", text: "Causa Cambio Estados"
  end

  test "creating a Causa cambio estado" do
    visit causa_cambio_estados_url
    click_on "New Causa Cambio Estado"

    fill_in "Comentario", with: @causa_cambio_estado.comentario
    fill_in "Nombre", with: @causa_cambio_estado.nombre
    click_on "Create Causa cambio estado"

    assert_text "Causa cambio estado was successfully created"
    click_on "Back"
  end

  test "updating a Causa cambio estado" do
    visit causa_cambio_estados_url
    click_on "Edit", match: :first

    fill_in "Comentario", with: @causa_cambio_estado.comentario
    fill_in "Nombre", with: @causa_cambio_estado.nombre
    click_on "Update Causa cambio estado"

    assert_text "Causa cambio estado was successfully updated"
    click_on "Back"
  end

  test "destroying a Causa cambio estado" do
    visit causa_cambio_estados_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Causa cambio estado was successfully destroyed"
  end
end
