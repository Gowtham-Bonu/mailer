require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_path
    assert_response :success
  end

  test "should go to new" do
    get new_user_path
    assert_response :success
  end

  test "should create a new user" do
    user = User.new(name: "kish", email: "kish@mail.com")
    post users_path, params: {user: {name: user.name, email: user.email}}
    assert_emails 1 do
      UserMailer.with(user: user).welcome_email.deliver_now
    end
    assert_redirected_to root_path
  end
end
