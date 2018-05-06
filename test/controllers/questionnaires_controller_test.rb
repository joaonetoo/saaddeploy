require 'test_helper'

class QuestionnairesControllerTest < ActionController::TestCase
  test "should get complete" do
    get :complete
    assert_response :success
  end

end
