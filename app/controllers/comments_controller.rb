class CommentsController < ApplicationController
  before_action :require_user!

  def create
    @commentable = if params[:listing_id]
      Listing.find(params[:listing_id])
    elsif params[:comment_id]
      Comment.find(params[:comment_id])
    end

    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      render turbo_stream: turbo_stream.prepend("comments", @comment)
    else
      render turbo_stream: turbo_stream.replace(@comment, partial: "comments/form", locals: {comment: @comment, commentable: @comment.commentable})
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if current_user == @comment.user
      @comment.destroy
      render turbo_stream: turbo_stream.remove(@comment)
    else
      redirect_to @comment.commentable, error: "You aren't permitted to do that"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
