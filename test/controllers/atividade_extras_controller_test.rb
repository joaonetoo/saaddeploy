require 'test_helper'

class AtividadeExtrasControllerTest < ActionController::TestCase
  setup do
    @atividade_extra = atividade_extras(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:atividade_extras)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create atividade_extra" do
    assert_difference('AtividadeExtra.count') do
      post :create, atividade_extra: { data_final: @atividade_extra.data_final, descricao: @atividade_extra.descricao, titulo: @atividade_extra.titulo, user_id: @atividade_extra.user_id }
    end

    assert_redirected_to atividade_extra_path(assigns(:atividade_extra))
  end

  test "should show atividade_extra" do
    get :show, id: @atividade_extra
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @atividade_extra
    assert_response :success
  end

  test "should update atividade_extra" do
    patch :update, id: @atividade_extra, atividade_extra: { data_final: @atividade_extra.data_final, descricao: @atividade_extra.descricao, titulo: @atividade_extra.titulo, user_id: @atividade_extra.user_id }
    assert_redirected_to atividade_extra_path(assigns(:atividade_extra))
  end

  test "should destroy atividade_extra" do
    assert_difference('AtividadeExtra.count', -1) do
      delete :destroy, id: @atividade_extra
    end

    assert_redirected_to atividade_extras_path
  end
end
