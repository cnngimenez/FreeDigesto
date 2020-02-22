require 'test_helper'

class PoseeDescPartsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @posee_desc_part = posee_desc_parts(:one)
  end

  test "should get index" do
    get posee_desc_parts_url
    assert_response :success
  end

  test "should get new" do
    get new_posee_desc_part_url
    assert_response :success
  end

  test "should create posee_desc_part" do
    assert_difference('PoseeDescPart.count') do
      post posee_desc_parts_url, params: { posee_desc_part: { descriptor_particular_id: @posee_desc_part.descriptor_particular_id, norma_id: @posee_desc_part.norma_id } }
    end

    assert_redirected_to posee_desc_part_url(PoseeDescPart.last)
  end

  test "should show posee_desc_part" do
    get posee_desc_part_url(@posee_desc_part)
    assert_response :success
  end

  test "should get edit" do
    get edit_posee_desc_part_url(@posee_desc_part)
    assert_response :success
  end

  test "should update posee_desc_part" do
    patch posee_desc_part_url(@posee_desc_part), params: { posee_desc_part: { descriptor_particular_id: @posee_desc_part.descriptor_particular_id, norma_id: @posee_desc_part.norma_id } }
    assert_redirected_to posee_desc_part_url(@posee_desc_part)
  end

  test "should destroy posee_desc_part" do
    assert_difference('PoseeDescPart.count', -1) do
      delete posee_desc_part_url(@posee_desc_part)
    end

    assert_redirected_to posee_desc_parts_url
  end
end
