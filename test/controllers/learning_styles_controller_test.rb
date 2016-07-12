require 'test_helper'

class LearningStylesControllerTest < ActionController::TestCase
  setup do
    @learning_style = learning_styles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:learning_styles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create learning_style" do
    assert_difference('LearningStyle.count') do
      post :create, learning_style: { descricao: @learning_style.descricao, nome: @learning_style.nome, sigla: @learning_style.sigla }
    end

    assert_redirected_to learning_style_path(assigns(:learning_style))
  end

  test "should show learning_style" do
    get :show, id: @learning_style
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @learning_style
    assert_response :success
  end

  test "should update learning_style" do
    patch :update, id: @learning_style, learning_style: { descricao: @learning_style.descricao, nome: @learning_style.nome, sigla: @learning_style.sigla }
    assert_redirected_to learning_style_path(assigns(:learning_style))
  end

  test "should destroy learning_style" do
    assert_difference('LearningStyle.count', -1) do
      delete :destroy, id: @learning_style
    end

    assert_redirected_to learning_styles_path
  end
end
