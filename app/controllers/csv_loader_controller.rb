class CsvLoaderController < ApplicationController
  protect_from_forgery with: :null_session
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
    redirect_to csv_loader_path
  end

  private

  def check_authorization
    if !current_user
      redirect_to :root
    end
  end
end
