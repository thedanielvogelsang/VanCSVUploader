require 'csv'
class CSVImporter

  attr_reader :file

  def initialize(file)
    @file = file
  end

  def run
    #do something crazy
    send_email
  end

  def send_email
    SendEmailJob.perform_later
  end

end
