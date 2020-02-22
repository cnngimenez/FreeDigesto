require "application_system_test_case"

class TienePrivilegiosTest < ApplicationSystemTestCase
  setup do
    @tiene_privilegio = tiene_privilegios(:one)
  end

  test "visiting the index" do
    visit tiene_privilegios_url
    assert_selector "h1", text: "Tiene Privilegios"
  end

  test "creating a Tiene privilegio" do
    visit tiene_privilegios_url
    click_on "New Tiene Privilegio"

    fill_in "Privilegio", with: @tiene_privilegio.privilegio_id
    fill_in "Usuario", with: @tiene_privilegio.usuario_id
    click_on "Create Tiene privilegio"

    assert_text "Tiene privilegio was successfully created"
    click_on "Back"
  end

  test "updating a Tiene privilegio" do
    visit tiene_privilegios_url
    click_on "Edit", match: :first

    fill_in "Privilegio", with: @tiene_privilegio.privilegio_id
    fill_in "Usuario", with: @tiene_privilegio.usuario_id
    click_on "Update Tiene privilegio"

    assert_text "Tiene privilegio was successfully updated"
    click_on "Back"
  end

  test "destroying a Tiene privilegio" do
    visit tiene_privilegios_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Tiene privilegio was successfully destroyed"
  end
end
