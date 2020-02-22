require 'test_helper'

class DescriptorGeneralsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:descriptor_generals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create descriptor_general" do
    assert_difference('DescriptorGeneral.count') do
      post :create, :descriptor_general => { }
    end

    assert_redirected_to descriptor_general_path(assigns(:descriptor_general))
  end

  test "should show descriptor_general" do
    get :show, :id => descriptor_generals(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => descriptor_generals(:one).to_param
    assert_response :success
  end

  test "should update descriptor_general" do
    put :update, :id => descriptor_generals(:one).to_param, :descriptor_general => { }
    assert_redirected_to descriptor_general_path(assigns(:descriptor_general))
  end

  test "should destroy descriptor_general" do
    assert_difference('DescriptorGeneral.count', -1) do
      delete :destroy, :id => descriptor_generals(:one).to_param
    end

    assert_redirected_to descriptor_generals_path
  end
end
