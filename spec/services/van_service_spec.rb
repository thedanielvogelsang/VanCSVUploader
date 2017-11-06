require 'rails_helper'
require 'csv'

RSpec.describe VanService do
  before(:each) do
    @service = VanService.new
  end
  it 'can connect with VAN upon initialization' do
    expect(@service).to be_truthy
  end
  xit 'can retrieve all input Types for canvass responses' do
    expected_inputs =  [{:inputTypeId=>11, :name=>"API"},
        {:inputTypeId=>9, :name=>"Auto Dial"},
        {:inputTypeId=>5, :name=>"Back End"},
        {:inputTypeId=>4, :name=>"Bulk"},
        {:inputTypeId=>15, :name=>"Form View"},
        {:inputTypeId=>16, :name=>"Grid View"},
        {:inputTypeId=>24, :name=>"Live Call"},
        {:inputTypeId=>2, :name=>"Manual"},
        {:inputTypeId=>14, :name=>"Mobile"},
        {:inputTypeId=>6, :name=>"Purchased"},
        {:inputTypeId=>17, :name=>"Script View"},
        {:inputTypeId=>7, :name=>"Special"},
        {:inputTypeId=>8, :name=>"Tasks"},
        {:inputTypeId=>10, :name=>"VPB"},
        {:inputTypeId=>23, :name=>"Website"}]
    expect(@service.get).to eq(expected_inputs)
  end
  xit 'can find the vanId of a form entry' do
    survey_results_2_people = [{:firstName=>"Randall",
         :lastName=>"Clarke",
         :zipOrPostalCode=>88990,
         :phoneNumber=>"1234566789",
         :address=>["1279 Address Lane"],
         :city=>"Menphis",
         :stateOrProvince=>"CO",
         :email=>"randy_dandy@gmail.com",
         :responses=>
          {:canvassContext=>{:contactTypeId=>15, :inputTypeId=>11, :dataCanvassed=>'2017-11-04 21:08:19 -0600'},
           :resultCodeId=>"null",
           :responses=>
            [{:surveyQuestionId=>123, :surveyResponseId=>1, :type=>"SurveyResponse"},
             {:surveyQuestionId=>234, :surveyResponseId=>nil, :type=>"SurveyResponse"},
             {:surveyQuestionId=>345, :surveyResponseId=>0, :type=>"SurveyResponse"}]}},
          {:firstName=>"Beatrice",
           :lastName=>"Santiago",
           :zipOrPostalCode=>nil,
           :phoneNumber=>"7229001177",
           :address=>["908 Beautiful Ct."],
           :city=>"Braxille",
           :stateOrProvince=>"PR",
           :email=>"bea@nononsense.net",
           :responses=>
            {:canvassContext=>{:contactTypeId=>15, :inputTypeId=>11, :dataCanvassed=>'2017-11-04 21:08:19 -0600'},
             :resultCodeId=>"null",
             :responses=>
              [{:surveyQuestionId=>123, :surveyResponseId=>1, :type=>"SurveyResponse"},
               {:surveyQuestionId=>123, :surveyResponseId=>nil, :type=>"SurveyResponse"},
               {:surveyQuestionId=>234, :surveyResponseId=>"C", :type=>"SurveyResponse"},
               {:surveyQuestionId=>234, :surveyResponseId=>"F", :type=>"SurveyResponse"},
               {:surveyQuestionId=>234, :surveyResponseId=>"K", :type=>"SurveyResponse"},
               {:surveyQuestionId=>234, :surveyResponseId=>"T", :type=>"SurveyResponse"},
               {:surveyQuestionId=>345, :surveyResponseId=>9, :type=>"SurveyResponse"}]}}]

      VanService.find_or_create_all_and_post(survey_results)
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
  xit 'can post canvass results given a known vanId' do
    id = 101073946
    #works with or without canvassContext
    responses = {"canvassContext": {
                  "contactTypeId": 2,
                  "inputTypeId": 14,
                  "dateCanvassed": "2012-04-09T00:00:00-04:00"
                },
                "resultCodeId": "null",
                "responses":
          [{"activistCodeId": 4272694, "action": "Apply", "type": "ActivistCode"},
           {"surveyQuestionId":268212, "surveyResponseId": 1118839, "type": "SurveyResponse"},
           {"surveyQuestionId":268218, "surveyResponseId": 1118864, "type": "SurveyResponse"},
           {"surveyQuestionId":268221, "surveyResponseId": 1118884, "type": "SurveyResponse"}]
        }
    results = @service.post(id, responses)
  end
end
