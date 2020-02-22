require 'test_helper'

class LugarPublicacionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lugar_publicacions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lugar_publicacion" do
    assert_difference('LugarPublicacion.count') do
      post :create, :lugar_publicacion => { }
    end

    assert_redirected_to lugar_publicacion_path(assigns(:lugar_publicacion))
  end

  test "should show lugar_publicacion" do
    get :show, :id => lugar_publicacions(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => lugar_publicacions(:one).to_param
    assert_response :success
  end

  test "should update lugar_publicacion" do
    put :update, :id => lugar_publicacions(:one).to_param, :lugar_publicacion => { }
    assert_redirected_to lugar_publicacion_path(assigns(:lugar_publicacion))
  end

  test "should destroy lugar_publicacion" do
    assert_difference('LugarPublicacion.count', -1) do
      delete :destroy, :id => lugar_publicacions(:one).to_param
    end

    assert_redirected_to lugar_publicacions_path
  end
end
