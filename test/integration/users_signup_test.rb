require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test 'invalid signup information' do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: {user: {name: '',
                                        email: 'user@einvalid',
                                        password: 'foo',
                                        password_confirmation: 'bar'} }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test 'valid signup information' do
    get signup_path
    assert_difference 'User.count', 1 do
      post signup_path, params: {user: {name: 'Example Name',
                                        email: 'example@example.com',
                                        password: 'simplepass',
                                        password_confirmation: 'simplepass'} }
    end
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?  
    assert_not flash.empty? 
  end
end
