class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:message] = "Login successful"
      redirect_to csv_loader_path
    else
      flash[:message] = "Username/password invalid, try again"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:message] = 'Logout successful'
    redirect_to root_path
  end

  private
    def session_params
      params.require(:session).permit(:username, :password)
    end
end
