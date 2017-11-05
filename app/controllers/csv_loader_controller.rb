class CsvLoaderController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :check_authorization, only: [:show]

  def show
    @user = current_user
  end

  def create
    file_path_to_save_to = "./tmp/#{DateTime.now}_file.csv"
    File.write(file_path_to_save_to, request.raw_post)
    CsvImporterJob.perform_later(file_path_to_save_to)
    redirect_to csv_loader_path
  end

  def check_authorization
    if !current_user
      redirect_to :root
    end
  end
end
