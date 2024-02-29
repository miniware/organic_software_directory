# require "test_helper"

# class VotesControllerTest < ActionDispatch::IntegrationTest
#   setup do
#     @user = users(:one)
#     @comment = comments(:one)

      # NOT WORKING
#     passwordless_sign_in @user # Assuming you have a method to sign in users in your tests
#   end

#   test "should create vote" do
#     assert_difference("Vote.count", 1) do
#       post comment_vote_path(comment_id: @comment.id), xhr: true
#     end
#     assert_response :success
#   end

#   test "should destroy vote" do
#     vote = Vote.create(votable: @comment, user: @user)
#     assert_difference("Vote.count", -1) do
#       delete comment_vote_path(comment_id: @comment.id, id: vote.id), xhr: true
#     end
#     assert_response :success
#   end
# end