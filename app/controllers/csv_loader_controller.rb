class CsvLoaderController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :check_authorization, only: [:show]

  def show
    if session[:notice] == 57454
    end
  end

  def create
    binding.pry
    file_path_to_save_to = "./tmp/#{DateTime.now}_file.csv"
    CsvImporterJob.perform_later(file_path_to_save_to)
    flash[:notice] = "File Uploaded. A summary will be sent upon completion."
    redirect_to csv_loader_path
    session[:notice] = 57454
  end

  private

  def check_authorization
    if !current_user
      redirect_to :root
    end
  end
end
