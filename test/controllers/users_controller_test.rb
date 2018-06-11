require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get signup_path
    assert_select "title", "Sign Up | Ruby on Rails Tutorial Sample App"
    assert_response :success
  end

end
