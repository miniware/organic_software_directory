class UsersController < ApplicationController
  before_action :require_user!, only: [:edit, :update]

  def new
    return unless get_invite
    @user = User.new(email: @invite.recipient_email)
  end

  def create
    get_invite
    @user = User.new(user_params.merge(email: @invite.recipient_email))

    if @user.save
      @invite.update!(accepted_by_id: @user.id)
      sign_in(create_passwordless_session(@user))
      redirect_to root_path, notice: "Welcome to OSD!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find_by!(handle: params[:id])
  end

  def edit
    redirect_to edit_user_path(current_user.handle) unless params[:id] == current_user.handle
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(update_user_params)
      redirect_to @user, notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:handle, :bio)
  end

  def update_user_params
    params.require(:user).permit(:bio)
  end

  def get_invite
    @invite = Invite.find(session[:invite_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Invite not found."
    false
  end
end
