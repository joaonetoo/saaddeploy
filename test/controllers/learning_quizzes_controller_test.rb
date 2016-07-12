require 'test_helper'

class LearningQuizzesControllerTest < ActionController::TestCase
  setup do
    @learning_quiz = learning_quizzes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:learning_quizzes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create learning_quiz" do
    assert_difference('LearningQuiz.count') do
      post :create, learning_quiz: { data_final: @learning_quiz.data_final, user_id: @learning_quiz.user_id }
    end

    assert_redirected_to learning_quiz_path(assigns(:learning_quiz))
  end

  test "should show learning_quiz" do
    get :show, id: @learning_quiz
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @learning_quiz
    assert_response :success
  end

  test "should update learning_quiz" do
    patch :update, id: @learning_quiz, learning_quiz: { data_final: @learning_quiz.data_final, user_id: @learning_quiz.user_id }
    assert_redirected_to learning_quiz_path(assigns(:learning_quiz))
  end

  test "should destroy learning_quiz" do
    assert_difference('LearningQuiz.count', -1) do
      delete :destroy, id: @learning_quiz
    end

    assert_redirected_to learning_quizzes_path
  end
end
