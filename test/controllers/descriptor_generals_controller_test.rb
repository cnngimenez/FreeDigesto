require 'test_helper'

class DescriptorGeneralsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @descriptor_general = descriptor_generals(:one)
  end

  test "should get index" do
    get descriptor_generals_url
    assert_response :success
  end

  test "should get new" do
    get new_descriptor_general_url
    assert_response :success
  end

  test "should create descriptor_general" do
    assert_difference('DescriptorGeneral.count') do
      post descriptor_generals_url, params: { descriptor_general: { comentario: @descriptor_general.comentario, nombre: @descriptor_general.nombre } }
    end

    assert_redirected_to descriptor_general_url(DescriptorGeneral.last)
  end

  test "should show descriptor_general" do
    get descriptor_general_url(@descriptor_general)
    assert_response :success
  end

  test "should get edit" do
    get edit_descriptor_general_url(@descriptor_general)
    assert_response :success
  end

  test "should update descriptor_general" do
    patch descriptor_general_url(@descriptor_general), params: { descriptor_general: { comentario: @descriptor_general.comentario, nombre: @descriptor_general.nombre } }
    assert_redirected_to descriptor_general_url(@descriptor_general)
  end

  test "should destroy descriptor_general" do
    assert_difference('DescriptorGeneral.count', -1) do
      delete descriptor_general_url(@descriptor_general)
    end

    assert_redirected_to descriptor_generals_url
  end
end
