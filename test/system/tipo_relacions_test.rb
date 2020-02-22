require "application_system_test_case"

class TipoRelacionsTest < ApplicationSystemTestCase
  setup do
    @tipo_relacion = tipo_relacions(:one)
  end

  test "visiting the index" do
    visit tipo_relacions_url
    assert_selector "h1", text: "Tipo Relacions"
  end

  test "creating a Tipo relacion" do
    visit tipo_relacions_url
    click_on "New Tipo Relacion"

    fill_in "Comentario", with: @tipo_relacion.comentario
    fill_in "Nombre", with: @tipo_relacion.nombre
    click_on "Create Tipo relacion"

    assert_text "Tipo relacion was successfully created"
    click_on "Back"
  end

  test "updating a Tipo relacion" do
    visit tipo_relacions_url
    click_on "Edit", match: :first

    fill_in "Comentario", with: @tipo_relacion.comentario
    fill_in "Nombre", with: @tipo_relacion.nombre
    click_on "Update Tipo relacion"

    assert_text "Tipo relacion was successfully updated"
    click_on "Back"
  end

  test "destroying a Tipo relacion" do
    visit tipo_relacions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Tipo relacion was successfully destroyed"
  end
end
