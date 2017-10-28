class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Logged in as #{@user.username}"
    end
    redirect_to csv_loader_path(@user.id)
  end

  private

  def user_params
    params.require(:user).permit(:username,
                                 :password)
  end
end
