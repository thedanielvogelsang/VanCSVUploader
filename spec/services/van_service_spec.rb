require 'rails_helper'
require 'csv'

RSpec.describe VanService do
  before(:each) do
    @service = VanService.new
  end
  it 'can connect with VAN upon initialization' do
    expect(@service).to be_truthy
  end
  it 'can find the id of a person' do
      survey_results_1_person =  {:firstName=>"Vogelsang",
         :lastName=>"Daniel",
         :zipOrPostalCode=>80218,
         :phoneNumber=>"13162076632",
         :address=>["515 N Clarkson"],
         :city=>"Denver",
         :stateOrProvince=>"CO",
         :email=>"dr.vogelsang26@gmail.com",
         :responses=>
          {:canvassContext=>{:contactTypeId=>15, :inputTypeId=>11, :dataCanvassed=>'2017-11-04 21:08:19 -0600'},
           :resultCodeId=>"null",
           :responses=>
            [{:surveyQuestionId=>123, :surveyResponseId=>1, :type=>"SurveyResponse"},
             {:surveyQuestionId=>234, :surveyResponseId=>nil, :type=>"SurveyResponse"},
             {:surveyQuestionId=>345, :surveyResponseId=>0, :type=>"SurveyResponse"}]
          }
        }

      id = @service.find_or_create(survey_results_1_person)
      expect(id).to eq(101073946)
  end
  it 'can post canvass results given a known vanId' do
    id = 101073946
    responses = {"resultCodeId": "null",
     "responses":
      [{"activistCodeId": 4272694, "action": "Apply", "type": "ActivistCode"},
       {"surveyQuestionId":268212, "surveyResponseId": 1118839, "type": "SurveyResponse"},
       {"surveyQuestionId":268218, "surveyResponseId": 1118864, "type": "SurveyResponse"},
       {"surveyQuestionId":268221, "surveyResponseId": 1118884, "type": "SurveyResponse"}]
    }
    results = @service.post(id, responses)
  end
end
