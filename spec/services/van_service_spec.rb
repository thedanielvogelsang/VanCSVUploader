require 'rails_helper'
require 'csv'

RSpec.describe VanService do
  before(:each) do
    @responses = []
    file = 'spec/csv_files/good_csv.csv'
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      @responses <<  SurveyConverter.convert(first_name: row[:firstname],
                          last_name: row[:lastname],
                          address: row[:address],
                          phone: row[:phone],
                          email: row[:email],
                          surveyQuestion1: row[:answer_1],
                          surveyQuestion2: row[:answer_2],
                          surveyQuestion3: row[:answer_3]
                        )
    @service = VanService.new
    end
  end
  it 'can connect with VAN upon initialization' do
    expect(@service).to be_truthy
  end
  it 'can retrieve all input Types for canvass responses' do
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
end
