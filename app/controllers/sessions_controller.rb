class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to csv_loader_path(@user.id)
    else
      flash[:message] = "Username/password invalid, try again"
      render :new
    end
  end

  def destroy
  end
  private
    def session_params
      params.require(:session).permit(:username, :password)
    end
end
