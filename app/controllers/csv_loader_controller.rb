class CsvLoaderController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :check_authorization, only: [:show]

  def show
    if flash[:notice]
      puts 'Yes'
    else
      puts 'No'
    end
  end

  def create
    file_path_to_save_to = "./tmp/#{DateTime.now}_file.csv"
    CsvImporterJob.perform_later(file_path_to_save_to)
    flash[:notice] = "File Uploaded. A summary will be sent upon completion."
  end

  private

  def check_authorization
    if !current_user
      redirect_to :root
    end
  end

  def current_user
    @user = User.find(session[:user_id]) if session[:user_id]
  end
end
