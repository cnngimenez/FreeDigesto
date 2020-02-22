require 'test_helper'

class RelacionaConNormasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:relaciona_con_normas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create relaciona_con_norma" do
    assert_difference('RelacionaConNorma.count') do
      post :create, :relaciona_con_norma => { }
    end

    assert_redirected_to relaciona_con_norma_path(assigns(:relaciona_con_norma))
  end

  test "should show relaciona_con_norma" do
    get :show, :id => relaciona_con_normas(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => relaciona_con_normas(:one).to_param
    assert_response :success
  end

  test "should update relaciona_con_norma" do
    put :update, :id => relaciona_con_normas(:one).to_param, :relaciona_con_norma => { }
    assert_redirected_to relaciona_con_norma_path(assigns(:relaciona_con_norma))
  end

  test "should destroy relaciona_con_norma" do
    assert_difference('RelacionaConNorma.count', -1) do
      delete :destroy, :id => relaciona_con_normas(:one).to_param
    end

    assert_redirected_to relaciona_con_normas_path
  end
end
