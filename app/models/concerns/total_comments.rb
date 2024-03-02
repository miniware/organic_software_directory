module TotalComments
  extend ActiveSupport::Concern

  included do
    def total_comments
      @total_comments ||= count_comments_recursively
    end

    private

    def count_comments_recursively
      comments.includes(:comments).to_a.sum { |comment| 1 + comment.total_comments }
    end
  end
end
