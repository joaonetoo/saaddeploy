require 'test_helper'

class AnswerCasesControllerTest < ActionController::TestCase
  setup do
    @answer_case = answer_cases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:answer_cases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create answer_case" do
    assert_difference('AnswerCase.count') do
      post :create, answer_case: { question_id: @answer_case.question_id, resposta: @answer_case.resposta, user_id: @answer_case.user_id }
    end

    assert_redirected_to answer_case_path(assigns(:answer_case))
  end

  test "should show answer_case" do
    get :show, id: @answer_case
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @answer_case
    assert_response :success
  end

  test "should update answer_case" do
    patch :update, id: @answer_case, answer_case: { question_id: @answer_case.question_id, resposta: @answer_case.resposta, user_id: @answer_case.user_id }
    assert_redirected_to answer_case_path(assigns(:answer_case))
  end

  test "should destroy answer_case" do
    assert_difference('AnswerCase.count', -1) do
      delete :destroy, id: @answer_case
    end

    assert_redirected_to answer_cases_path
  end
end
