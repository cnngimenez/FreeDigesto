require 'test_helper'

class DescriptorParticularsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @descriptor_particular = descriptor_particulars(:one)
  end

  test "should get index" do
    get descriptor_particulars_url
    assert_response :success
  end

  test "should get new" do
    get new_descriptor_particular_url
    assert_response :success
  end

  test "should create descriptor_particular" do
    assert_difference('DescriptorParticular.count') do
      post descriptor_particulars_url, params: { descriptor_particular: { comentario: @descriptor_particular.comentario, descriptor_general_id: @descriptor_particular.descriptor_general_id, nombre: @descriptor_particular.nombre } }
    end

    assert_redirected_to descriptor_particular_url(DescriptorParticular.last)
  end

  test "should show descriptor_particular" do
    get descriptor_particular_url(@descriptor_particular)
    assert_response :success
  end

  test "should get edit" do
    get edit_descriptor_particular_url(@descriptor_particular)
    assert_response :success
  end

  test "should update descriptor_particular" do
    patch descriptor_particular_url(@descriptor_particular), params: { descriptor_particular: { comentario: @descriptor_particular.comentario, descriptor_general_id: @descriptor_particular.descriptor_general_id, nombre: @descriptor_particular.nombre } }
    assert_redirected_to descriptor_particular_url(@descriptor_particular)
  end

  test "should destroy descriptor_particular" do
    assert_difference('DescriptorParticular.count', -1) do
      delete descriptor_particular_url(@descriptor_particular)
    end

    assert_redirected_to descriptor_particulars_url
  end
end
