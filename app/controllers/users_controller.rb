class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new(user_params)
    if password_check && @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Logged in as #{@user.username}"
      redirect_to csv_loader_path
    else
      redirect_to :new_user
    end
  end

  private

  def user_params
    params.require(:user).permit(:username,
                                 :password,
                                 )
  end

  def password_check
    params[:user][:password] == params[:user][:password_confirmation]
  end
end
