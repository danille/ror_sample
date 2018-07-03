require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user =         users(:dmytro)
    @archer_user = users(:archer)
  end

  test 'should get new' do
    get signup_path
    assert_response :success
    assert_select 'title', 'Sign Up | Ruby on Rails Tutorial Sample App'
  end

  test 'should redirect edit when not logged in' do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect update when not logged in' do
    patch user_path(@user), params: {user: {name: @user.name,
                                            email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect index when logged in' do
    get users_path
    assert_redirected_to login_url
  end

  test 'should not allow admin attribute to be edited via the web' do
    log_in_as @archer_user
    assert_not @archer_user.admin?
    patch user_path(@archer_user), params: {user: {password: '',
                                                   password_confirmation: '',
                                                   admin: true
                                                         } }
    assert_not @archer_user.reload.admin?

  end

  test 'should redirect destroy when not logged in' do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_path
  end

  test 'should redirect destroy to the root when not admin' do
    log_in_as @archer_user
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_path
  end
end
