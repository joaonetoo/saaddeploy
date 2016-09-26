require 'test_helper'

class WeaknessAnswersControllerTest < ActionController::TestCase
  setup do
    @weakness_answer = weakness_answers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:weakness_answers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create weakness_answer" do
    assert_difference('WeaknessAnswer.count') do
      post :create, weakness_answer: { text: @weakness_answer.text, weakness_id: @weakness_answer.weakness_id }
    end

    assert_redirected_to weakness_answer_path(assigns(:weakness_answer))
  end

  test "should show weakness_answer" do
    get :show, id: @weakness_answer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @weakness_answer
    assert_response :success
  end

  test "should update weakness_answer" do
    patch :update, id: @weakness_answer, weakness_answer: { text: @weakness_answer.text, weakness_id: @weakness_answer.weakness_id }
    assert_redirected_to weakness_answer_path(assigns(:weakness_answer))
  end

  test "should destroy weakness_answer" do
    assert_difference('WeaknessAnswer.count', -1) do
      delete :destroy, id: @weakness_answer
    end

    assert_redirected_to weakness_answers_path
  end
end
