require 'rails_helper'
require 'csv'

RSpec.describe 'survey_converter', type: :model do
  context "can take a good CSV row by row" do
    xit "#returns the right format for VAN upload" do
      correct_format = {
            "canvassContext": {
              "contactTypeId": 2,
              "inputTypeId": 14,
              "dateCanvassed": "2012-04-09T00:00:00-04:00"
            },
            "resultCodeId": 'null',
            "responses": [ ]
          }
      file = 'spec/csv_files/good_single_line_form_data.csv'
      survey_responses = []
      CSV.foreach(file, headers: true,
                        header_converters: :symbol) do |row|
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
      expect(survey_responses[0][:responses][:canvassContext][:contactTypeId]).to eq(8)
      expect(survey_responses[0].keys).to eq([:firstName, :lastName,  :zipOrPostalCode, :phoneNumber, :address, :city, :stateOrProvince, :email, :responses])
    end
    it "#returns name, address, phone and email
          for VAN lookup AND returns json ready for
            VAN service to post to VAN" do
      file = 'spec/csv_files/good_csv.csv'
      survey_responses = []
      CSV.foreach(file, headers: true,
                        header_converters: :symbol) do |row|
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
      expect(survey_responses[0][:firstName]).to eq('Randall')
      expect(survey_responses[0][:responses].class).to eq(Hash)
      expect(survey_responses[1][:firstName]).to eq('Beatrice')
      expect(survey_responses[1][:lastName]).to eq('Santiago')
      #checks zip for three different types of errors: too long, too short, not an Int
      expect(survey_responses[1][:zipOrPostalCode]).to eq(nil)
      expect(survey_responses[2][:zipOrPostalCode]).to eq(nil)
      expect(survey_responses[4][:zipOrPostalCode]).to eq(nil)
      #checks both types of phone entries XXXXXXXXXX and (YYY)-YYY-YYYY
      expect(survey_responses[1][:phoneNumber]).to eq('7229001177')
      expect(survey_responses[2][:phoneNumber]).to eq('9120812590')

      expect(survey_responses[2][:email]).to eq('georg@afc.com')
      expect(survey_responses[3][:address][0]).to eq('98 Last House Ave.')
      expect(survey_responses[4][:address][1]).to eq('300')

      expect(survey_responses[3][:city]).to eq('Scaryville')
      expect(survey_responses[3][:stateOrProvince]).to eq('LA')
      expect(survey_responses[3][:zipOrPostalCode]).to eq(80212)
      expect(survey_responses[3][:responses][:responses][1][:surveyResponseId]).to eq(1118839)
    end
    it "#returns within its hash an accurate list of survey_response ids" do
      file = 'spec/csv_files/good_csv.csv'
      survey_responses = []
      CSV.foreach(file, headers: true,
                        header_converters: :symbol) do |row|
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
      randalls_answers = survey_responses[0][:responses][:responses]
      beas_answers = survey_responses[1][:responses][:responses]
      janes_answers = survey_responses[3][:responses][:responses]
      # p janes_answers

      #synched with first entry
      expect(janes_answers[1][:surveyQuestionId]).to eq(268212)
      expect(beas_answers[1][:surveyQuestionId]).to eq(268212)

      #simple three
      expect(randalls_answers[1][:surveyQuestionId]).to eq(268212)
      expect(randalls_answers[1][:surveyResponseId]).to eq(1118839)
      expect(randalls_answers[2][:surveyQuestionId]).to eq(268218)
      expect(randalls_answers[2][:surveyResponseId]).to eq(nil)
      expect(randalls_answers[3][:surveyQuestionId]).to eq(268221)
      expect(randalls_answers[3][:surveyResponseId]).to eq(1118885)
      #beas multi-answers

      expect(beas_answers[1][:surveyQuestionId]).to eq(268212)
      expect(beas_answers[2][:surveyQuestionId]).to eq(268212)
      expect(beas_answers[3][:surveyQuestionId]).to eq(268218)
      expect(beas_answers[4][:surveyQuestionId]).to eq(268218)
      expect(beas_answers[5][:surveyQuestionId]).to eq(268218)
      expect(beas_answers[6][:surveyQuestionId]).to eq(268218)
      expect(beas_answers[6][:surveyResponseId]).to eq(1118880)
      expect(beas_answers[7][:surveyQuestionId]).to eq(268221)
      expect(beas_answers[7][:surveyResponseId]).to eq(1118884)

      #checking response ids
      expect(janes_answers[1][:surveyQuestionId]).to eq(268212)
      expect(janes_answers[1][:surveyResponseId]).to eq(1118839)
      expect(janes_answers[2][:surveyQuestionId]).to eq(268212)
      expect(janes_answers[2][:surveyResponseId]).to eq(nil)
      expect(janes_answers[3][:surveyQuestionId]).to eq(268212)
      expect(janes_answers[3][:surveyResponseId]).to eq(1118844)
      expect(janes_answers[4][:surveyQuestionId]).to eq(268218)
      expect(janes_answers[4][:surveyResponseId]).to eq(nil)
      expect(janes_answers[5][:surveyQuestionId]).to eq(268221)
      expect(janes_answers[5][:surveyResponseId]).to eq(1118885)


    end
  end
end
