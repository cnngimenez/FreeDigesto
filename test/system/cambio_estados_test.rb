require "application_system_test_case"

class CambioEstadosTest < ApplicationSystemTestCase
  setup do
    @cambio_estado = cambio_estados(:one)
  end

  test "visiting the index" do
    visit cambio_estados_url
    assert_selector "h1", text: "Cambio Estados"
  end

  test "creating a Cambio estado" do
    visit cambio_estados_url
    click_on "New Cambio Estado"

    fill_in "Causa cambio estado", with: @cambio_estado.causa_cambio_estado_id
    fill_in "Comentario", with: @cambio_estado.comentario
    fill_in "Estado", with: @cambio_estado.estado_id
    fill_in "Fecha cambio", with: @cambio_estado.fecha_cambio
    fill_in "Fecha creacion", with: @cambio_estado.fecha_creacion
    fill_in "Norma", with: @cambio_estado.norma_id
    click_on "Create Cambio estado"

    assert_text "Cambio estado was successfully created"
    click_on "Back"
  end

  test "updating a Cambio estado" do
    visit cambio_estados_url
    click_on "Edit", match: :first

    fill_in "Causa cambio estado", with: @cambio_estado.causa_cambio_estado_id
    fill_in "Comentario", with: @cambio_estado.comentario
    fill_in "Estado", with: @cambio_estado.estado_id
    fill_in "Fecha cambio", with: @cambio_estado.fecha_cambio
    fill_in "Fecha creacion", with: @cambio_estado.fecha_creacion
    fill_in "Norma", with: @cambio_estado.norma_id
    click_on "Update Cambio estado"

    assert_text "Cambio estado was successfully updated"
    click_on "Back"
  end

  test "destroying a Cambio estado" do
    visit cambio_estados_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Cambio estado was successfully destroyed"
  end
end
