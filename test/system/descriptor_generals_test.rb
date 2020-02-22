require "application_system_test_case"

class DescriptorGeneralsTest < ApplicationSystemTestCase
  setup do
    @descriptor_general = descriptor_generals(:one)
  end

  test "visiting the index" do
    visit descriptor_generals_url
    assert_selector "h1", text: "Descriptor Generals"
  end

  test "creating a Descriptor general" do
    visit descriptor_generals_url
    click_on "New Descriptor General"

    fill_in "Comentario", with: @descriptor_general.comentario
    fill_in "Nombre", with: @descriptor_general.nombre
    click_on "Create Descriptor general"

    assert_text "Descriptor general was successfully created"
    click_on "Back"
  end

  test "updating a Descriptor general" do
    visit descriptor_generals_url
    click_on "Edit", match: :first

    fill_in "Comentario", with: @descriptor_general.comentario
    fill_in "Nombre", with: @descriptor_general.nombre
    click_on "Update Descriptor general"

    assert_text "Descriptor general was successfully updated"
    click_on "Back"
  end

  test "destroying a Descriptor general" do
    visit descriptor_generals_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Descriptor general was successfully destroyed"
  end
end
