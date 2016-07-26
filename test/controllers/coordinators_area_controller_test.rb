require 'test_helper'

class CoordinatorsAreaControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get create_video" do
    get :create_video
    assert_response :success
  end

  test "should get list" do
    get :list
    assert_response :success
  end

  test "should get search_plans" do
    get :search_plans
    assert_response :success
  end

  test "should get send_video" do
    get :send_video
    assert_response :success
  end

  test "should get show_plan" do
    get :show_plan
    assert_response :success
  end

  test "should get videos_index" do
    get :videos_index
    assert_response :success
  end

end
