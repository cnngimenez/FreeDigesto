require "application_system_test_case"

class PoseeDescriptorsTest < ApplicationSystemTestCase
  setup do
    @posee_descriptor = posee_descriptors(:one)
  end

  test "visiting the index" do
    visit posee_descriptors_url
    assert_selector "h1", text: "Posee Descriptors"
  end

  test "creating a Posee descriptor" do
    visit posee_descriptors_url
    click_on "New Posee Descriptor"

    fill_in "Descriptor general", with: @posee_descriptor.descriptor_general_id
    fill_in "Norma", with: @posee_descriptor.norma_id
    click_on "Create Posee descriptor"

    assert_text "Posee descriptor was successfully created"
    click_on "Back"
  end

  test "updating a Posee descriptor" do
    visit posee_descriptors_url
    click_on "Edit", match: :first

    fill_in "Descriptor general", with: @posee_descriptor.descriptor_general_id
    fill_in "Norma", with: @posee_descriptor.norma_id
    click_on "Update Posee descriptor"

    assert_text "Posee descriptor was successfully updated"
    click_on "Back"
  end

  test "destroying a Posee descriptor" do
    visit posee_descriptors_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Posee descriptor was successfully destroyed"
  end
end
