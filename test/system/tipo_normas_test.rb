require "application_system_test_case"

class TipoNormasTest < ApplicationSystemTestCase
  setup do
    @tipo_norma = tipo_normas(:one)
  end

  test "visiting the index" do
    visit tipo_normas_url
    assert_selector "h1", text: "Tipo Normas"
  end

  test "creating a Tipo norma" do
    visit tipo_normas_url
    click_on "New Tipo Norma"

    fill_in "Comentario", with: @tipo_norma.comentario
    fill_in "Nombre", with: @tipo_norma.nombre
    click_on "Create Tipo norma"

    assert_text "Tipo norma was successfully created"
    click_on "Back"
  end

  test "updating a Tipo norma" do
    visit tipo_normas_url
    click_on "Edit", match: :first

    fill_in "Comentario", with: @tipo_norma.comentario
    fill_in "Nombre", with: @tipo_norma.nombre
    click_on "Update Tipo norma"

    assert_text "Tipo norma was successfully updated"
    click_on "Back"
  end

  test "destroying a Tipo norma" do
    visit tipo_normas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Tipo norma was successfully destroyed"
  end
end
