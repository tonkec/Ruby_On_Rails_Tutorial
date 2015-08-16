require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  test "invalid log in" do
    get login_path
    assert_template "sessions/new"
    post login_path, session: { email: "", password: "" }
    assert_template "sessions/new"
    assert_not flash.empty?
    get contact_path
    assert flash.empty?
  end
end
