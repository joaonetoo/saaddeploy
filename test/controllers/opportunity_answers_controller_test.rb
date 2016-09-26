require 'test_helper'

class OpportunityAnswersControllerTest < ActionController::TestCase
  setup do
    @opportunity_answer = opportunity_answers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:opportunity_answers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create opportunity_answer" do
    assert_difference('OpportunityAnswer.count') do
      post :create, opportunity_answer: { opportunity_id: @opportunity_answer.opportunity_id, text: @opportunity_answer.text }
    end

    assert_redirected_to opportunity_answer_path(assigns(:opportunity_answer))
  end

  test "should show opportunity_answer" do
    get :show, id: @opportunity_answer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @opportunity_answer
    assert_response :success
  end

  test "should update opportunity_answer" do
    patch :update, id: @opportunity_answer, opportunity_answer: { opportunity_id: @opportunity_answer.opportunity_id, text: @opportunity_answer.text }
    assert_redirected_to opportunity_answer_path(assigns(:opportunity_answer))
  end

  test "should destroy opportunity_answer" do
    assert_difference('OpportunityAnswer.count', -1) do
      delete :destroy, id: @opportunity_answer
    end

    assert_redirected_to opportunity_answers_path
  end
end
