require "application_system_test_case"

class CambioAplicadosTest < ApplicationSystemTestCase
  setup do
    @cambio_aplicado = cambio_aplicados(:one)
  end

  test "visiting the index" do
    visit cambio_aplicados_url
    assert_selector "h1", text: "Cambio Aplicados"
  end

  test "creating a Cambio aplicado" do
    visit cambio_aplicados_url
    click_on "New Cambio Aplicado"

    fill_in "Cambio estado", with: @cambio_aplicado.cambio_estado_id
    fill_in "Comentario", with: @cambio_aplicado.comentario
    fill_in "Fecha aplicado", with: @cambio_aplicado.fecha_aplicado
    click_on "Create Cambio aplicado"

    assert_text "Cambio aplicado was successfully created"
    click_on "Back"
  end

  test "updating a Cambio aplicado" do
    visit cambio_aplicados_url
    click_on "Edit", match: :first

    fill_in "Cambio estado", with: @cambio_aplicado.cambio_estado_id
    fill_in "Comentario", with: @cambio_aplicado.comentario
    fill_in "Fecha aplicado", with: @cambio_aplicado.fecha_aplicado
    click_on "Update Cambio aplicado"

    assert_text "Cambio aplicado was successfully updated"
    click_on "Back"
  end

  test "destroying a Cambio aplicado" do
    visit cambio_aplicados_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Cambio aplicado was successfully destroyed"
  end
end
