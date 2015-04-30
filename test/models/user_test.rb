require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "Example User", email: "foo@example.com",
                      password: "foobarbiz", password_confirmation: "foobarbiz")
  end
  
  test "should be valid" do
    assert @user.valid?
  end
  
  test "name should be present" do
    @user.name = "  "
    assert_not @user.valid?
  end
  
  test "email should be present"do
    @user.email = "   "
    assert_not @user.valid?
  end
  
  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end
  
  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  test "email validation should not accept invalid addresses" do
    invalid_addresses = %w[@user@example.com user@foo,com bad@user+foo.com
                        user@foo user_at_foo.com user@foo_bar.com user@foo..bar.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should not be valid"
    end
  end
  
  test "should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "email addresses should be unique" do
    duplicate_user = @user.dup 
    duplicate_user.email = @user.email.upcase
    @user.save
#    puts "#{duplicate_user.email} | #{@user.email}"  
    assert_not duplicate_user.valid?
  end
  
  test "name should have a minimum length" do
    @user.name = "a"
    assert_not @user.valid?
  end
  
  test "password and confirmation should match" do
    # Just change the confirmation for mismatch 
    #   with minimum length
    @user.password_confirmation = "a" * 8
    assert_not @user.valid?
  end
  
  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 7
    assert_not @user.valid?
  end
  
  test "email should always be saved downcase" do
    mix_case_email = "fOo@Bar.COm"
    @user.email = mix_case_email
    @user.save
    assert_equal @user.reload.email, mix_case_email.downcase
  end
end
