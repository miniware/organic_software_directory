# This is for comments of comments, eg reply threads
class Comments::CommentsController < CommentsController
  before_action :set_commentable

  private

  def set_commentable
    @commentable = Comment.find(params[:comment_id])
  end
end
