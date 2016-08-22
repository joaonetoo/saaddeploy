require 'test_helper'

class AnswerNotesControllerTest < ActionController::TestCase
  setup do
    @answer_note = answer_notes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:answer_notes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create answer_note" do
    assert_difference('AnswerNote.count') do
      post :create, answer_note: { answer_id: @answer_note.answer_id, observacao: @answer_note.observacao, user_id: @answer_note.user_id }
    end

    assert_redirected_to answer_note_path(assigns(:answer_note))
  end

  test "should show answer_note" do
    get :show, id: @answer_note
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @answer_note
    assert_response :success
  end

  test "should update answer_note" do
    patch :update, id: @answer_note, answer_note: { answer_id: @answer_note.answer_id, observacao: @answer_note.observacao, user_id: @answer_note.user_id }
    assert_redirected_to answer_note_path(assigns(:answer_note))
  end

  test "should destroy answer_note" do
    assert_difference('AnswerNote.count', -1) do
      delete :destroy, id: @answer_note
    end

    assert_redirected_to answer_notes_path
  end
end
