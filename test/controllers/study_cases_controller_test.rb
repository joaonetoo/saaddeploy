require 'test_helper'

class StudyCasesControllerTest < ActionController::TestCase
  setup do
    @study_case = study_cases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:study_cases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create study_case" do
    assert_difference('StudyCase.count') do
      post :create, study_case: { abstract: @study_case.abstract, area: @study_case.area, author: @study_case.author, recommended: @study_case.recommended, title: @study_case.title, topic2: @study_case.topic2, topic: @study_case.topic }
    end

    assert_redirected_to study_case_path(assigns(:study_case))
  end

  test "should show study_case" do
    get :show, id: @study_case
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @study_case
    assert_response :success
  end

  test "should update study_case" do
    patch :update, id: @study_case, study_case: { abstract: @study_case.abstract, area: @study_case.area, author: @study_case.author, recommended: @study_case.recommended, title: @study_case.title, topic2: @study_case.topic2, topic: @study_case.topic }
    assert_redirected_to study_case_path(assigns(:study_case))
  end

  test "should destroy study_case" do
    assert_difference('StudyCase.count', -1) do
      delete :destroy, id: @study_case
    end

    assert_redirected_to study_cases_path
  end
end
