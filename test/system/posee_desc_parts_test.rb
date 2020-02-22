require "application_system_test_case"

class PoseeDescPartsTest < ApplicationSystemTestCase
  setup do
    @posee_desc_part = posee_desc_parts(:one)
  end

  test "visiting the index" do
    visit posee_desc_parts_url
    assert_selector "h1", text: "Posee Desc Parts"
  end

  test "creating a Posee desc part" do
    visit posee_desc_parts_url
    click_on "New Posee Desc Part"

    fill_in "Descriptor particular", with: @posee_desc_part.descriptor_particular_id
    fill_in "Norma", with: @posee_desc_part.norma_id
    click_on "Create Posee desc part"

    assert_text "Posee desc part was successfully created"
    click_on "Back"
  end

  test "updating a Posee desc part" do
    visit posee_desc_parts_url
    click_on "Edit", match: :first

    fill_in "Descriptor particular", with: @posee_desc_part.descriptor_particular_id
    fill_in "Norma", with: @posee_desc_part.norma_id
    click_on "Update Posee desc part"

    assert_text "Posee desc part was successfully updated"
    click_on "Back"
  end

  test "destroying a Posee desc part" do
    visit posee_desc_parts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Posee desc part was successfully destroyed"
  end
end
