require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  
  def setup
    @base_title = "Wild Philosophy Blog"
  end
  
  test "should get new" do
    get :new
    assert_response :success
    assert_select "title", "Log In | #{@base_title}"
  end

end
