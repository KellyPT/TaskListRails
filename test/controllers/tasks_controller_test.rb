require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  test "not-logged-in user should get redirected from pages to homepage" do
    session.delete(:user_id)
    get :index
    assert_response :redirect
    assert_redirected_to root_path
  end

  test "Logged in user can see exactly her pages" do
    session[:user_id] = users(:ada).id
    get :index
    assert_response :success
    assert_template "tasks/index"
    tasks_from_controller = assigns(:tasks)
    assert_equal tasks_from_controller.length, users(:ada).tasks.length

    tasks_from_controller.each do |task|
      assert_includes users(:ada).tasks, task
    end
  end
end
