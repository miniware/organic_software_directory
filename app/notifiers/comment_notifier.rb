class CommentNotifier < ApplicationNotifier
  # deliver_by :email do |config|
  #   config.mailer = "UserMailer"
  #   config.method = "new_comment"
  #   config.wait = 30.min
  #   config.params = ->(recipient) { {user: recipient} }
  # end

  notification_methods do
    def on
      params[:on]
    end
  end
end
