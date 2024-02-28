class CommentsController < ApplicationController
  before_action :require_user!

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      render turbo_stream: [
        turbo_stream.prepend(comment_section_id, partial: "comments/comment", locals: {comment: @comment}),
        turbo_stream.replace("new_comment_form", partial: "comments/form", locals: {comment: @commentable.comments.build})
      ]
    else
      render turbo_stream: turbo_stream.replace(@comment, partial: "comments/form", locals: {comment: @comment})
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

  def comment_section_id
    "comments_for_#{@commentable.model_name.param_key}_#{@commentable.id}"
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
