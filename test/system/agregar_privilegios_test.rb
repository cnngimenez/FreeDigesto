require "application_system_test_case"

class AgregarPrivilegiosTest < ApplicationSystemTestCase
  setup do
    @agregar_privilegio = agregar_privilegios(:one)
  end

  test "visiting the index" do
    visit agregar_privilegios_url
    assert_selector "h1", text: "Agregar Privilegios"
  end

  test "creating a Agregar privilegio" do
    visit agregar_privilegios_url
    click_on "New Agregar Privilegio"

    fill_in "Patron privilegio", with: @agregar_privilegio.Patron_privilegio_id
    fill_in "Privilegio", with: @agregar_privilegio.Privilegio_id
    click_on "Create Agregar privilegio"

    assert_text "Agregar privilegio was successfully created"
    click_on "Back"
  end

  test "updating a Agregar privilegio" do
    visit agregar_privilegios_url
    click_on "Edit", match: :first

    fill_in "Patron privilegio", with: @agregar_privilegio.Patron_privilegio_id
    fill_in "Privilegio", with: @agregar_privilegio.Privilegio_id
    click_on "Update Agregar privilegio"

    assert_text "Agregar privilegio was successfully updated"
    click_on "Back"
  end

  test "destroying a Agregar privilegio" do
    visit agregar_privilegios_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Agregar privilegio was successfully destroyed"
  end
end
