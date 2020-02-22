require "application_system_test_case"

class PatronPrivilegiosTest < ApplicationSystemTestCase
  setup do
    @patron_privilegio = patron_privilegios(:one)
  end

  test "visiting the index" do
    visit patron_privilegios_url
    assert_selector "h1", text: "Patron Privilegios"
  end

  test "creating a Patron privilegio" do
    visit patron_privilegios_url
    click_on "New Patron Privilegio"

    fill_in "Comentario", with: @patron_privilegio.comentario
    fill_in "Nombre", with: @patron_privilegio.nombre
    click_on "Create Patron privilegio"

    assert_text "Patron privilegio was successfully created"
    click_on "Back"
  end

  test "updating a Patron privilegio" do
    visit patron_privilegios_url
    click_on "Edit", match: :first

    fill_in "Comentario", with: @patron_privilegio.comentario
    fill_in "Nombre", with: @patron_privilegio.nombre
    click_on "Update Patron privilegio"

    assert_text "Patron privilegio was successfully updated"
    click_on "Back"
  end

  test "destroying a Patron privilegio" do
    visit patron_privilegios_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Patron privilegio was successfully destroyed"
  end
end
