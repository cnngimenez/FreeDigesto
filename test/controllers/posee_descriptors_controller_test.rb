require 'test_helper'

class PoseeDescriptorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @posee_descriptor = posee_descriptors(:one)
  end

  test "should get index" do
    get posee_descriptors_url
    assert_response :success
  end

  test "should get new" do
    get new_posee_descriptor_url
    assert_response :success
  end

  test "should create posee_descriptor" do
    assert_difference('PoseeDescriptor.count') do
      post posee_descriptors_url, params: { posee_descriptor: { descriptor_general_id: @posee_descriptor.descriptor_general_id, norma_id: @posee_descriptor.norma_id } }
    end

    assert_redirected_to posee_descriptor_url(PoseeDescriptor.last)
  end

  test "should show posee_descriptor" do
    get posee_descriptor_url(@posee_descriptor)
    assert_response :success
  end

  test "should get edit" do
    get edit_posee_descriptor_url(@posee_descriptor)
    assert_response :success
  end

  test "should update posee_descriptor" do
    patch posee_descriptor_url(@posee_descriptor), params: { posee_descriptor: { descriptor_general_id: @posee_descriptor.descriptor_general_id, norma_id: @posee_descriptor.norma_id } }
    assert_redirected_to posee_descriptor_url(@posee_descriptor)
  end

  test "should destroy posee_descriptor" do
    assert_difference('PoseeDescriptor.count', -1) do
      delete posee_descriptor_url(@posee_descriptor)
    end

    assert_redirected_to posee_descriptors_url
  end
end
