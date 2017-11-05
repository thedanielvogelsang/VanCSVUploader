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
         :zipOrPostalCode=>80216,
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

      id = VanService.new.find_or_create(survey_results_1_person)
      expect(id).to eq()
  end
  xit 'can find post canvass results given a known vanId' do

  end
end
