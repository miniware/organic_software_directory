class InvitesController < ApplicationController
  before_action :require_user!, except: :show

  def index
    @invites = current_user.invites
  end

  def new
    @invite = current_user.invites.new
  end

  def create
    @invite = current_user.invites.new(invite_params)
    @message = params[:message]

    if @invite.save
      InviteMailer.send_invite(@invite, @message).deliver_now
      redirect_to invites_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @token = params[:token]
    @invite = Invite.find_by_token_for!(:invite_code, @token)

    redirect_to @invite.accepted_by if @invite.accepted?
  end

  private

  def invite_params
    params.require(:invite).permit(:recipient_email)
  end
end
