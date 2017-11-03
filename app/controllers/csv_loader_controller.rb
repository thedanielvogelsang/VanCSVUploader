class CsvLoaderController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :check_authorization, only: [:show]

  def show
    @user = current_user
    if session[:notice] == 57454
    flash[:notice] = "File Uploaded. A summary will be sent upon completion."
    end
  end

  def create
    file_path_to_save_to = "./tmp/#{DateTime.now}_file.csv"
    File.write(file_path_to_save_to, request.raw_post)
    CsvImporterJob.perform_later(file_path_to_save_to)
    redirect_to csv_loader_path
    session[:notice] = 57454
  end

  def check_authorization
    if !current_user
      redirect_to :root
    end
  end
end
