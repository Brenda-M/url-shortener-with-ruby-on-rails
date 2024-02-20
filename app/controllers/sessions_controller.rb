class SessionsController < ApplicationController

  before_action :redirect_if_authenticated, only: [:create, :new]

  def new
    redirect_to root_path if current_user
  end

  def create
    @user = User.find_by(email: user_params[:email])

    if @user && @user.authenticate(user_params[:password])
      login @user
      redirect_to root_path, notice: "Signed in"
    else
      flash.now[:alert] = "Incorrect email or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to auth_login_url, notice: 'Logged out successfully!'
  end


  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
