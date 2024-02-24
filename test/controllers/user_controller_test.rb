require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    post users_url, params: {user: {email: "newuser@example.com", handle: "newuserhandle"}}
    assert_equal "newuser@example.com", User.last.email
    assert_equal "newuserhandle", User.last.handle
    assert_redirected_to user_url(User.last)
    follow_redirect!
    assert_response :success
  end

  test "should show user" do
    user = users(:one)
    get user_url(user)
    assert_response :success
  end

  test "should get edit" do
    user = users(:one)
    get edit_user_url(user)
    assert_response :success
  end

  test "should update user" do
    user = users(:one)
    patch user_url(user), params: {user: {bio: "Updated bio"}}
    assert_redirected_to user_url(user)
  end
end
