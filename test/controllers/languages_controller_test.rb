require 'test_helper'

class LanguagesControllerTest < ActionController::TestCase
  test "should get change" do
    get :change
    assert_response :success
  end

end
