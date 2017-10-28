class CsvLoaderController < ApplicationController
  before_action :check_authorization

  def show
    @user = current_user
  end

  def check_authorization
    if !current_user
      redirect_to :root
    end
  end
end
