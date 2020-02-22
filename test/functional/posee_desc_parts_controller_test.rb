require 'test_helper'

class PoseeDescPartsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posee_desc_parts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create posee_desc_part" do
    assert_difference('PoseeDescPart.count') do
      post :create, :posee_desc_part => { }
    end

    assert_redirected_to posee_desc_part_path(assigns(:posee_desc_part))
  end

  test "should show posee_desc_part" do
    get :show, :id => posee_desc_parts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => posee_desc_parts(:one).to_param
    assert_response :success
  end

  test "should update posee_desc_part" do
    put :update, :id => posee_desc_parts(:one).to_param, :posee_desc_part => { }
    assert_redirected_to posee_desc_part_path(assigns(:posee_desc_part))
  end

  test "should destroy posee_desc_part" do
    assert_difference('PoseeDescPart.count', -1) do
      delete :destroy, :id => posee_desc_parts(:one).to_param
    end

    assert_redirected_to posee_desc_parts_path
  end
end
