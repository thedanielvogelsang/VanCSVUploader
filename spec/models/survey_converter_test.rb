require 'rails_helper'
require 'csv'

RSpec.describe 'survey_converter', type: :model do
  context "can take a good CSV row by row" do
    it "#returns name, address, phone and email
          for VAN lookup AND returns json ready for
            VAN service to post to VAN" do
      file = 'spec/csv_files/good_csv.csv'
      survey_responses = []
      CSV.foreach(file, headers: true,
                        header_converters: :symbol) do |row|
          survey_responses <<  SurveyConverter.convert(first_name: row[:firstname],
                              last_name: row[:lastname],
                              address: row[:address],
                              phone: row[:phone],
                              email: row[:email],
                              surveyQuestion1: row[:answer_1],
                              surveyQuestion2: row[:answer_2],
                              surveyQuestion3: row[:answer_3]
                            )
      end
      expect(survey_responses[0][:first]).to eq('daniel')
      expect(survey_responses[0][:responses].class).to eq(Hash)
      expect(survey_responses[1][:first]).to eq('jack')
      expect(survey_responses[1][:last]).to eq('sparrow')
      expect(survey_responses[2][:phone]).to eq('016-333-6332')
      expect(survey_responses[3][:email]).to eq('lucius@gmail.com')
      expect(survey_responses[4][:address]).to eq('515 Spawns Lake Dr Derby CO 80212')
      expect(survey_responses[4][:responses][:responses][0][:surveyResponseId]).to eq('N')
    end
    it "#returns within its hash an accurate list of survey_response ids" do
      file = 'spec/csv_files/good_csv.csv'
      survey_responses = []
      CSV.foreach(file, headers: true,
                        header_converters: :symbol) do |row|
          survey_responses <<  SurveyConverter.convert(first_name: row[:firstname],
                              last_name: row[:lastname],
                              address: row[:address],
                              phone: row[:phone],
                              email: row[:email],
                              surveyQuestion1: row[:answer_1],
                              surveyQuestion2: row[:answer_2],
                              surveyQuestion3: row[:answer_3]
                            )
      end
      dans_answers = survey_responses[0][:responses][:responses]
      jacks_answers = survey_responses[1][:responses][:responses]
      penelopes_answers = survey_responses[4][:responses][:responses]
      p penelopes_answers
      expect(penelopes_answers.count).to eq(3)
      expect(penelopes_answers.first[:surveyQuestionId]).to eq(123)
      expect(penelopes_answers.second[:surveyQuestionId]).to eq(234)
      expect(penelopes_answers.third[:surveyQuestionId]).to eq(345)
      expect(penelopes_answers.first[:surveyResponseId]).to eq('N')
      expect(penelopes_answers.second[:surveyResponseId]).to eq(5)
      expect(penelopes_answers.third[:surveyResponseId]).to eq('E')
    end
  end
end
