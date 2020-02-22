require "application_system_test_case"

class PrivilegiosTest < ApplicationSystemTestCase
  setup do
    @privilegio = privilegios(:one)
  end

  test "visiting the index" do
    visit privilegios_url
    assert_selector "h1", text: "Privilegios"
  end

  test "creating a Privilegio" do
    visit privilegios_url
    click_on "New Privilegio"

    fill_in "Comentario", with: @privilegio.comentario
    fill_in "Nombre", with: @privilegio.nombre
    click_on "Create Privilegio"

    assert_text "Privilegio was successfully created"
    click_on "Back"
  end

  test "updating a Privilegio" do
    visit privilegios_url
    click_on "Edit", match: :first

    fill_in "Comentario", with: @privilegio.comentario
    fill_in "Nombre", with: @privilegio.nombre
    click_on "Update Privilegio"

    assert_text "Privilegio was successfully updated"
    click_on "Back"
  end

  test "destroying a Privilegio" do
    visit privilegios_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Privilegio was successfully destroyed"
  end
end
