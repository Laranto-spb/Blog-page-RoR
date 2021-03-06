require "test_helper"

class SignupUserTest < ActionDispatch::IntegrationTest

  test 'sign up a new user' do

    get '/signup'
    assert_response :success

    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: "Tatsiana", email: "tatsiana@gmail.com", password: "123"}}
      assert_response :redirect
    end

    follow_redirect!

    assert_response :success
  
  end
end