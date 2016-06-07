require 'test_helper'

class AnchorinfosControllerTest < ActionController::TestCase
  setup do
    @anchorinfo = anchorinfos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:anchorinfos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create anchorinfo" do
    assert_difference('Anchorinfo.count') do
      post :create, anchorinfo: { descricao: @anchorinfo.descricao, nome: @anchorinfo.nome, perfil: @anchorinfo.perfil, perspectiva: @anchorinfo.perspectiva, tipo: @anchorinfo.tipo }
    end

    assert_redirected_to anchorinfo_path(assigns(:anchorinfo))
  end

  test "should show anchorinfo" do
    get :show, id: @anchorinfo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @anchorinfo
    assert_response :success
  end

  test "should update anchorinfo" do
    patch :update, id: @anchorinfo, anchorinfo: { descricao: @anchorinfo.descricao, nome: @anchorinfo.nome, perfil: @anchorinfo.perfil, perspectiva: @anchorinfo.perspectiva, tipo: @anchorinfo.tipo }
    assert_redirected_to anchorinfo_path(assigns(:anchorinfo))
  end

  test "should destroy anchorinfo" do
    assert_difference('Anchorinfo.count', -1) do
      delete :destroy, id: @anchorinfo
    end

    assert_redirected_to anchorinfos_path
  end
end
