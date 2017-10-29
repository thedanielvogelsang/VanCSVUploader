class CsvLoaderController < ApplicationController
  before_action :check_authorization, only: [:show]

  def show
    @user = current_user
  end

  def create
    file_path_to_save_to = './tmp/file.csv'
    File.write(file_path_to_save_to, params[:file].tempfile.read)
    CsvImporterJob.perform_later(file_path_to_save_to)
    redirect_to csv_loader_path, notice: "File Uploaded. A summary will be sent upon completion."
  end

  def check_authorization
    if !current_user
      redirect_to :root
    end
  end
end
