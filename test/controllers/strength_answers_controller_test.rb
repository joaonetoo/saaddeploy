require 'test_helper'

class StrengthAnswersControllerTest < ActionController::TestCase
  setup do
    @strength_answer = strength_answers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:strength_answers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create strength_answer" do
    assert_difference('StrengthAnswer.count') do
      post :create, strength_answer: { strength_id: @strength_answer.strength_id, text: @strength_answer.text }
    end

    assert_redirected_to strength_answer_path(assigns(:strength_answer))
  end

  test "should show strength_answer" do
    get :show, id: @strength_answer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @strength_answer
    assert_response :success
  end

  test "should update strength_answer" do
    patch :update, id: @strength_answer, strength_answer: { strength_id: @strength_answer.strength_id, text: @strength_answer.text }
    assert_redirected_to strength_answer_path(assigns(:strength_answer))
  end

  test "should destroy strength_answer" do
    assert_difference('StrengthAnswer.count', -1) do
      delete :destroy, id: @strength_answer
    end

    assert_redirected_to strength_answers_path
  end
end
