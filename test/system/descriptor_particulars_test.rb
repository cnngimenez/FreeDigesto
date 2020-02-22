require "application_system_test_case"

class DescriptorParticularsTest < ApplicationSystemTestCase
  setup do
    @descriptor_particular = descriptor_particulars(:one)
  end

  test "visiting the index" do
    visit descriptor_particulars_url
    assert_selector "h1", text: "Descriptor Particulars"
  end

  test "creating a Descriptor particular" do
    visit descriptor_particulars_url
    click_on "New Descriptor Particular"

    fill_in "Comentario", with: @descriptor_particular.comentario
    fill_in "Descriptor general", with: @descriptor_particular.descriptor_general_id
    fill_in "Nombre", with: @descriptor_particular.nombre
    click_on "Create Descriptor particular"

    assert_text "Descriptor particular was successfully created"
    click_on "Back"
  end

  test "updating a Descriptor particular" do
    visit descriptor_particulars_url
    click_on "Edit", match: :first

    fill_in "Comentario", with: @descriptor_particular.comentario
    fill_in "Descriptor general", with: @descriptor_particular.descriptor_general_id
    fill_in "Nombre", with: @descriptor_particular.nombre
    click_on "Update Descriptor particular"

    assert_text "Descriptor particular was successfully updated"
    click_on "Back"
  end

  test "destroying a Descriptor particular" do
    visit descriptor_particulars_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Descriptor particular was successfully destroyed"
  end
end
