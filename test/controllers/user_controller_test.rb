require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  setup do
    get root_path # activate session hash
  end

  # TODO: Figure out how to pass invite in session here
  # test "should create user" do
  #   invite = invites(:newuser)

  #   # integration_session[:invite_id] = invite.id

  #   # pp integration_session

  #   post :create, params: {user: {handle: "newuserhandle"}}
  #   assert_equal "newuser@example.com", User.last.email
  #   assert_equal "newuserhandle", User.last.handle
  #   assert_redirected_to user_url(User.last)
  #   follow_redirect!
  #   assert_response :success
  # end

  test "should show user" do
    user = users(:kermit)
    get user_url(user)
    assert_response :success
  end

  test "should get edit" do
    user = users(:kermit)
    passwordless_sign_in(user)
    get edit_user_url(user)
    assert_response :success
  end

  test "should update user" do
    user = users(:kermit)
    passwordless_sign_in(user)
    patch user_path(user), params: {user: {bio: "Updated bio"}}
    assert_redirected_to user_url(user)
    follow_redirect!
    user.reload
    assert_equal "Updated bio", user.bio
  end
end
