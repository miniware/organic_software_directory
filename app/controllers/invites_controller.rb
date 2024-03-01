class InvitesController < ApplicationController
  before_action :require_user!, except: :show

  def index
    @new_invite = current_user.invites.new if current_user.invites.remaining?
    @invites = current_user.invites
  end

  def new
    @invite = current_user.invites.new
  end

  def create
    @invite = current_user.invites.new(invite_params)
    @code = @invite.generate_token_for(:invite_code)

    if @invite.save
    else
      render "index", status: :unprocessable_entity
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
