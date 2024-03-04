module UserHelper
  def profile_link_for user
    username = (current_user && current_user == user) ? "You" : "@" + user.handle
    link_to username, user, class: "font-bold hover:underline", data: {turbo: false}
  end
end
