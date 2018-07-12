class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in_user!(@user)
      redirect_to users_url
    else
      flash.now[:errors] = ["Invalid username/email"]
      render :create
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
