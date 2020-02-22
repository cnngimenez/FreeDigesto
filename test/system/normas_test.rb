require "application_system_test_case"

class NormasTest < ApplicationSystemTestCase
  setup do
    @norma = normas(:one)
  end

  test "visiting the index" do
    visit normas_url
    assert_selector "h1", text: "Normas"
  end

  test "creating a Norma" do
    visit normas_url
    click_on "New Norma"

    fill_in "Citas doctorales", with: @norma.citas_doctorales
    fill_in "Citas jurisprudenciales", with: @norma.citas_jurisprudenciales
    fill_in "Comentarios", with: @norma.comentarios
    fill_in "Estado", with: @norma.estado_id
    fill_in "Fecha promulgacion", with: @norma.fecha_promulgacion
    fill_in "Fecha publicacion", with: @norma.fecha_publicacion
    fill_in "Fecha sancion", with: @norma.fecha_sancion
    check "General" if @norma.general
    fill_in "Lugar publicacion", with: @norma.lugar_publicacion_id
    fill_in "Numero", with: @norma.numero
    fill_in "Sumario", with: @norma.sumario
    fill_in "Texto", with: @norma.texto
    fill_in "Tipo norma", with: @norma.tipo_norma_id
    click_on "Create Norma"

    assert_text "Norma was successfully created"
    click_on "Back"
  end

  test "updating a Norma" do
    visit normas_url
    click_on "Edit", match: :first

    fill_in "Citas doctorales", with: @norma.citas_doctorales
    fill_in "Citas jurisprudenciales", with: @norma.citas_jurisprudenciales
    fill_in "Comentarios", with: @norma.comentarios
    fill_in "Estado", with: @norma.estado_id
    fill_in "Fecha promulgacion", with: @norma.fecha_promulgacion
    fill_in "Fecha publicacion", with: @norma.fecha_publicacion
    fill_in "Fecha sancion", with: @norma.fecha_sancion
    check "General" if @norma.general
    fill_in "Lugar publicacion", with: @norma.lugar_publicacion_id
    fill_in "Numero", with: @norma.numero
    fill_in "Sumario", with: @norma.sumario
    fill_in "Texto", with: @norma.texto
    fill_in "Tipo norma", with: @norma.tipo_norma_id
    click_on "Update Norma"

    assert_text "Norma was successfully updated"
    click_on "Back"
  end

  test "destroying a Norma" do
    visit normas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Norma was successfully destroyed"
  end
end
