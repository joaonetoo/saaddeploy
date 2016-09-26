require 'test_helper'

class ThreatsAnswersControllerTest < ActionController::TestCase
  setup do
    @threats_answer = threats_answers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:threats_answers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create threats_answer" do
    assert_difference('ThreatsAnswer.count') do
      post :create, threats_answer: { text: @threats_answer.text, threat_id: @threats_answer.threat_id }
    end

    assert_redirected_to threats_answer_path(assigns(:threats_answer))
  end

  test "should show threats_answer" do
    get :show, id: @threats_answer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @threats_answer
    assert_response :success
  end

  test "should update threats_answer" do
    patch :update, id: @threats_answer, threats_answer: { text: @threats_answer.text, threat_id: @threats_answer.threat_id }
    assert_redirected_to threats_answer_path(assigns(:threats_answer))
  end

  test "should destroy threats_answer" do
    assert_difference('ThreatsAnswer.count', -1) do
      delete :destroy, id: @threats_answer
    end

    assert_redirected_to threats_answers_path
  end
end
