require 'test_helper'

class RelacionaConNormasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @relaciona_con_norma = relaciona_con_normas(:one)
  end

  test "should get index" do
    get relaciona_con_normas_url
    assert_response :success
  end

  test "should get new" do
    get new_relaciona_con_norma_url
    assert_response :success
  end

  test "should create relaciona_con_norma" do
    assert_difference('RelacionaConNorma.count') do
      post relaciona_con_normas_url, params: { relaciona_con_norma: { norma_a_id: @relaciona_con_norma.norma_a_id, norma_b_id: @relaciona_con_norma.norma_b_id, tipo_relacion_id: @relaciona_con_norma.tipo_relacion_id } }
    end

    assert_redirected_to relaciona_con_norma_url(RelacionaConNorma.last)
  end

  test "should show relaciona_con_norma" do
    get relaciona_con_norma_url(@relaciona_con_norma)
    assert_response :success
  end

  test "should get edit" do
    get edit_relaciona_con_norma_url(@relaciona_con_norma)
    assert_response :success
  end

  test "should update relaciona_con_norma" do
    patch relaciona_con_norma_url(@relaciona_con_norma), params: { relaciona_con_norma: { norma_a_id: @relaciona_con_norma.norma_a_id, norma_b_id: @relaciona_con_norma.norma_b_id, tipo_relacion_id: @relaciona_con_norma.tipo_relacion_id } }
    assert_redirected_to relaciona_con_norma_url(@relaciona_con_norma)
  end

  test "should destroy relaciona_con_norma" do
    assert_difference('RelacionaConNorma.count', -1) do
      delete relaciona_con_norma_url(@relaciona_con_norma)
    end

    assert_redirected_to relaciona_con_normas_url
  end
end
