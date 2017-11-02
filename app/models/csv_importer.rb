require 'csv'
class CSVImporter

  attr_reader :file

  def initialize(file)
    @file = file
  end

  def run
    survey_responses = []
    CSV.foreach(@file, headers: true, header_converters: :symbol) do |row|
      survey_responses << SurveyConverter.convert(first_name: row[:firstName],
                                    last_name: row[:lastName],
                                    address: row[:address]
                                    phone: row[:phone],
                                    email: row[:email],
                                    surveyQuestion1: row[:answer_1],
                                    surveyQuestion2: row[:answer_2],
                                    surveyQuestion3: row[:answer_3])
    end
    # VanService.post_survey(survey_responses)
    #change this over to end of Post
    send_summary_email
  end

  def send_summary_email
    SendEmailJob.perform_later
  end

end
