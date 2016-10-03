require 'test_helper'

class LineCasesControllerTest < ActionController::TestCase
  setup do
    @line_case = line_cases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:line_cases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create line_case" do
    assert_difference('LineCase.count') do
      post :create, line_case: { data_final: @line_case.data_final, question_id: @line_case.question_id, study_case_id: @line_case.study_case_id, user_id: @line_case.user_id }
    end

    assert_redirected_to line_case_path(assigns(:line_case))
  end

  test "should show line_case" do
    get :show, id: @line_case
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @line_case
    assert_response :success
  end

  test "should update line_case" do
    patch :update, id: @line_case, line_case: { data_final: @line_case.data_final, question_id: @line_case.question_id, study_case_id: @line_case.study_case_id, user_id: @line_case.user_id }
    assert_redirected_to line_case_path(assigns(:line_case))
  end

  test "should destroy line_case" do
    assert_difference('LineCase.count', -1) do
      delete :destroy, id: @line_case
    end

    assert_redirected_to line_cases_path
  end
end
