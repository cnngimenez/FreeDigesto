require 'test_helper'

class DescriptorParticularsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:descriptor_particulars)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create descriptor_particular" do
    assert_difference('DescriptorParticular.count') do
      post :create, :descriptor_particular => { }
    end

    assert_redirected_to descriptor_particular_path(assigns(:descriptor_particular))
  end

  test "should show descriptor_particular" do
    get :show, :id => descriptor_particulars(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => descriptor_particulars(:one).to_param
    assert_response :success
  end

  test "should update descriptor_particular" do
    put :update, :id => descriptor_particulars(:one).to_param, :descriptor_particular => { }
    assert_redirected_to descriptor_particular_path(assigns(:descriptor_particular))
  end

  test "should destroy descriptor_particular" do
    assert_difference('DescriptorParticular.count', -1) do
      delete :destroy, :id => descriptor_particulars(:one).to_param
    end

    assert_redirected_to descriptor_particulars_path
  end
end
