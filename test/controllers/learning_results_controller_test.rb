require 'test_helper'

class LearningResultsControllerTest < ActionController::TestCase
  setup do
    @learning_result = learning_results(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:learning_results)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create learning_result" do
    assert_difference('LearningResult.count') do
      post :create, learning_result: { ca: @learning_result.ca, data_final: @learning_result.data_final, ea: @learning_result.ea, ec: @learning_result.ec, or: @learning_result.or, student_id: @learning_result.student_id, user_id: @learning_result.user_id }
    end

    assert_redirected_to learning_result_path(assigns(:learning_result))
  end

  test "should show learning_result" do
    get :show, id: @learning_result
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @learning_result
    assert_response :success
  end

  test "should update learning_result" do
    patch :update, id: @learning_result, learning_result: { ca: @learning_result.ca, data_final: @learning_result.data_final, ea: @learning_result.ea, ec: @learning_result.ec, or: @learning_result.or, student_id: @learning_result.student_id, user_id: @learning_result.user_id }
    assert_redirected_to learning_result_path(assigns(:learning_result))
  end

  test "should destroy learning_result" do
    assert_difference('LearningResult.count', -1) do
      delete :destroy, id: @learning_result
    end

    assert_redirected_to learning_results_path
  end
end
