require "test_helper"

class VoteTest < ActiveSupport::TestCase
  def setup
    @user = users(:kermit)
    @comment = comments(:rainbows)
    @vote = Vote.new(user: @user, votable: @comment)
  end

  test "should be valid" do
    assert @vote.valid?
  end

  test "should require a user" do
    @vote.user = nil
    assert_not @vote.valid?
  end

  test "should require a votable" do
    @vote.votable = nil
    assert_not @vote.valid?
  end

  test "user should not vote more than once per item" do
    duplicate_vote = @vote.dup
    @vote.save
    assert_not duplicate_vote.valid?
  end

  test "validate votable type" do
    invalid_votable = User.new # You can't vote on a user
    vote_with_invalid_votable = Vote.new(user: @user, votable: invalid_votable)
    assert_not vote_with_invalid_votable.valid?
  end
end