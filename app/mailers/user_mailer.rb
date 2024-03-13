class UserMailer < ApplicationMailer
  def new_comment
    @greeting = "Hi"

    mail to: params[:user].email
  end
end
