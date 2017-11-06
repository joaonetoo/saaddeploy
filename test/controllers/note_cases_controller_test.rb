require 'test_helper'

class NoteCasesControllerTest < ActionController::TestCase
  setup do
    @note_case = note_cases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:note_cases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create note_case" do
    assert_difference('NoteCase.count') do
      post :create, note_case: { answer_case_id: @note_case.answer_case_id, observacao: @note_case.observacao, user_id: @note_case.user_id }
    end

    assert_redirected_to note_case_path(assigns(:note_case))
  end

  test "should show note_case" do
    get :show, id: @note_case
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @note_case
    assert_response :success
  end

  test "should update note_case" do
    patch :update, id: @note_case, note_case: { answer_case_id: @note_case.answer_case_id, observacao: @note_case.observacao, user_id: @note_case.user_id }
    assert_redirected_to note_case_path(assigns(:note_case))
  end

  test "should destroy note_case" do
    assert_difference('NoteCase.count', -1) do
      delete :destroy, id: @note_case
    end

    assert_redirected_to note_cases_path
  end
end
