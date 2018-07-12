class UsersController < ApplicationController

  def show
    @user = User.find_by(id: params[:id])

    if @user
      render :show
    else
      redirect_to users_url
    end
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in_user!(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = ["Invalid email/password"]
      redirect_to new_user_url
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
