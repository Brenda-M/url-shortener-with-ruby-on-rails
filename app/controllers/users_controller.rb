class UsersController < ApplicationController

  before_action :redirect_if_authenticated

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      WelcomeJob.perform_async(@user.id, @user.username, @user.email)

      redirect_to auth_login_url, notice: 'Successfully registered!'
    else
      render :new, status: :unprocessable_entity
    end
  end


  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
