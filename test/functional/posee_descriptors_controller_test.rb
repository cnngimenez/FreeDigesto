require 'test_helper'

class PoseeDescriptorsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posee_descriptors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create posee_descriptor" do
    assert_difference('PoseeDescriptor.count') do
      post :create, :posee_descriptor => { }
    end

    assert_redirected_to posee_descriptor_path(assigns(:posee_descriptor))
  end

  test "should show posee_descriptor" do
    get :show, :id => posee_descriptors(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => posee_descriptors(:one).to_param
    assert_response :success
  end

  test "should update posee_descriptor" do
    put :update, :id => posee_descriptors(:one).to_param, :posee_descriptor => { }
    assert_redirected_to posee_descriptor_path(assigns(:posee_descriptor))
  end

  test "should destroy posee_descriptor" do
    assert_difference('PoseeDescriptor.count', -1) do
      delete :destroy, :id => posee_descriptors(:one).to_param
    end

    assert_redirected_to posee_descriptors_path
  end
end
