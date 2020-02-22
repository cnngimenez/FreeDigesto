require "application_system_test_case"

class RelacionaConNormasTest < ApplicationSystemTestCase
  setup do
    @relaciona_con_norma = relaciona_con_normas(:one)
  end

  test "visiting the index" do
    visit relaciona_con_normas_url
    assert_selector "h1", text: "Relaciona Con Normas"
  end

  test "creating a Relaciona con norma" do
    visit relaciona_con_normas_url
    click_on "New Relaciona Con Norma"

    fill_in "Norma a", with: @relaciona_con_norma.norma_a_id
    fill_in "Norma b", with: @relaciona_con_norma.norma_b_id
    fill_in "Tipo relacion", with: @relaciona_con_norma.tipo_relacion_id
    click_on "Create Relaciona con norma"

    assert_text "Relaciona con norma was successfully created"
    click_on "Back"
  end

  test "updating a Relaciona con norma" do
    visit relaciona_con_normas_url
    click_on "Edit", match: :first

    fill_in "Norma a", with: @relaciona_con_norma.norma_a_id
    fill_in "Norma b", with: @relaciona_con_norma.norma_b_id
    fill_in "Tipo relacion", with: @relaciona_con_norma.tipo_relacion_id
    click_on "Update Relaciona con norma"

    assert_text "Relaciona con norma was successfully updated"
    click_on "Back"
  end

  test "destroying a Relaciona con norma" do
    visit relaciona_con_normas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Relaciona con norma was successfully destroyed"
  end
end
