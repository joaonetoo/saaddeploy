require 'test_helper'

class WeaknessesControllerTest < ActionController::TestCase
  setup do
    @weakness = weaknesses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:weaknesses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create weakness" do
    assert_difference('Weakness.count') do
      post :create, weakness: { plano_id: @weakness.plano_id, text: @weakness.text }
    end

    assert_redirected_to weakness_path(assigns(:weakness))
  end

  test "should show weakness" do
    get :show, id: @weakness
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @weakness
    assert_response :success
  end

  test "should update weakness" do
    patch :update, id: @weakness, weakness: { plano_id: @weakness.plano_id, text: @weakness.text }
    assert_redirected_to weakness_path(assigns(:weakness))
  end

  test "should destroy weakness" do
    assert_difference('Weakness.count', -1) do
      delete :destroy, id: @weakness
    end

    assert_redirected_to weaknesses_path
  end
end
