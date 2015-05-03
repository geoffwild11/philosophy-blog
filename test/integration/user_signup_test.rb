require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  
  test "should not create invalid user" do
    get signup_path
    
    # Verify that attempting to create an invalid user doesn't work
    assert_no_difference 'User.count' do
      post users_path, user: { name: " ",
                               email: "ho@u",
                               password: "he",
                               paswword_confirmation: "nmatch" }
    end
    assert_template 'users/new'
  end
  
  test "should create a valid user" do
    get signup_path
    
    # Verify that sending valid user info to form works
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { name: "Test User",
                                            email: "test@example.com",
                                            password: "hellothere",
                                            password_confirmation: "hellothere" }
    end
    assert_template 'users/show'
    assert is_logged_in?
  end
  
  # Need a test for not creating duplicate user?
end
