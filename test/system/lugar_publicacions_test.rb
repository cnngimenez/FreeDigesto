require "application_system_test_case"

class LugarPublicacionsTest < ApplicationSystemTestCase
  setup do
    @lugar_publicacion = lugar_publicacions(:one)
  end

  test "visiting the index" do
    visit lugar_publicacions_url
    assert_selector "h1", text: "Lugar Publicacions"
  end

  test "creating a Lugar publicacion" do
    visit lugar_publicacions_url
    click_on "New Lugar Publicacion"

    fill_in "Comentario", with: @lugar_publicacion.comentario
    fill_in "Nombre", with: @lugar_publicacion.nombre
    click_on "Create Lugar publicacion"

    assert_text "Lugar publicacion was successfully created"
    click_on "Back"
  end

  test "updating a Lugar publicacion" do
    visit lugar_publicacions_url
    click_on "Edit", match: :first

    fill_in "Comentario", with: @lugar_publicacion.comentario
    fill_in "Nombre", with: @lugar_publicacion.nombre
    click_on "Update Lugar publicacion"

    assert_text "Lugar publicacion was successfully updated"
    click_on "Back"
  end

  test "destroying a Lugar publicacion" do
    visit lugar_publicacions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Lugar publicacion was successfully destroyed"
  end
end
