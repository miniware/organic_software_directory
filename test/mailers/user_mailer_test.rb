require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "new_comment" do
    mail = UserMailer.new_comment
    assert_equal "New comment", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
