require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def login_a_user
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
    get :create, { provider: "github"}
  end

  test "Can Create a user" do
    assert_difference('User.count', 1) do
      login_a_user
      assert_response :redirect
      assert_redirected_to sessions_login_path
    end
  end

  test "Logging in twice should not create two users" do
    assert_difference('User.count', 1) do
      login_a_user
    end

    assert_no_difference('User.count') do
      login_a_user
      assert_response :redirect
      assert_redirected_to sessions_login_path
      assert_not_nil session[:user_id]
    end
  end

  test "A not-logged-in user can see no tasks" do
    session[:user_id] = nil
    get :index_logout
    assert_template 'sessions/index_logout'
    assert_response :success
  end
end
