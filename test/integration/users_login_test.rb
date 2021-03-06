require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:geoff)
  end
  
  test "flash should appear only on intial load after failed login attempt" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: {email: "", password: "" }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  
  test "login with valid information followed by logout" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: {email: @user.email, password: "thisisatest" }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    # simulate user clicking log out in separate browser
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
  
  test "user log in with rememember me checked" do
    log_in_as(@user, remember_me: 1)
    #assert_not_nil cookies[:remember_token].nil?
    assert_equal assigns(:user).remember_token, cookies['remember_token']
  end
  
  test "user log in without remember me checked" do
    log_in_as(@user, remember_me: 0)
    assert_nil cookies[:remember_token]
  end
end
