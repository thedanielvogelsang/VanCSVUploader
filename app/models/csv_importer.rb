require 'csv'
class CSVImporter

  attr_reader :file

  def initialize(file)
    @file = file
  end

  def run
    survey_responses = []
    CSV.foreach(@file, headers: true, header_converters: :symbol) do |row|
      survey_responses <<  SurveyConverter.convert(first_name: row[:first_name],
                          last_name: row[:last_name],
                          addressLine1: row[:address],
                          city: row[:city],
                          stateOrProvince: row[:state],
                          zipOrPostalCode: row[:zipcode],
                          email: row[:email],
                          phoneNumber: row[:phone],
                          surveyQuestion1: row[:volunteer_needs],
                          surveyQuestion2: row[:language_help],
                          surveyQuestion3: row[:campaign_updates]
                        )
    end
    VanService.post(survey_responses)
    # VanService.post_survey(survey_responses)
    #change this over to end of Post
    send_summary_email
  end

  def send_summary_email
    SendEmailJob.perform_later
  end

end
