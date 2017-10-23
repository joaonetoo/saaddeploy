require 'test_helper'

class MainThemesControllerTest < ActionController::TestCase
  setup do
    @main_theme = main_themes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:main_themes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create main_theme" do
    assert_difference('MainTheme.count') do
      post :create, main_theme: { descricao: @main_theme.descricao }
    end

    assert_redirected_to main_theme_path(assigns(:main_theme))
  end

  test "should show main_theme" do
    get :show, id: @main_theme
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @main_theme
    assert_response :success
  end

  test "should update main_theme" do
    patch :update, id: @main_theme, main_theme: { descricao: @main_theme.descricao }
    assert_redirected_to main_theme_path(assigns(:main_theme))
  end

  test "should destroy main_theme" do
    assert_difference('MainTheme.count', -1) do
      delete :destroy, id: @main_theme
    end

    assert_redirected_to main_themes_path
  end
end
