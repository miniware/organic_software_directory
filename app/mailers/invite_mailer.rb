class InviteMailer < ApplicationMailer
  def send_invite(invite, message = nil)
    @invite = invite
    @message = message

    mail(
      to: @invite.recipient_email,
      reply_to: @invite.sent_by.email,
      subject: "Invitation to The Organic Software Directory"
    )
  end
end
