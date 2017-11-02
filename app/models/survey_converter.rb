class SurveyConverter

  def initialize(incoming_csv)
    @json_hash = json_hash_structure
    @csv_hash = incoming_csv
  end

  def clean_for_post
    van_service_package = Hash.new
    convert_me(0, @csv_hash[:surveyQuestion1])
    convert_me(1, @csv_hash[:surveyQuestion2])
    convert_me(2, @csv_hash[:surveyQuestion3])
    van_service_package[:responses] = @json_hash
    van_service_package[:first] = @csv_hash[:first_name]
    van_service_package[:last] = @csv_hash[:last_name]
    van_service_package[:phone] = @csv_hash[:phone]
    van_service_package[:email] = @csv_hash[:email]
    van_service_package[:address] = @csv_hash[:address]
    return van_service_package
  end


  def self.convert(csv_hash)
    new(csv_hash).clean_for_post
  end

  def json_hash_structure()
      canvass_response = {"canvassContext":{
        "contactTypeId": 15,
        "inputTypeId": 11,
        "dataCanvassed": Time.now
        },
      "resultCodeId": 'null',
      "responses": []
      }
      canvass_response
  end

  def convert_me(num, entry)
    survey_ids = [123, 234, 345]
    hash = {
      "surveyQuestionId": survey_ids[num],
      "surveyResponseId": nil,
      "type": "SurveyResponse"
      }

    hash[:surveyResponseId] = 1 if entry == 'KnockingDoors'
    hash[:surveyResponseId] = 2 if entry == 'CallVoters'
    hash[:surveyResponseId] = 3 if entry == 'HostingEvents'
    hash[:surveyResponseId] = 4 if entry == 'Support'
    hash[:surveyResponseId] = 5 if entry == 'UnsureYet'
    hash[:surveyResponseId] = 'Y' if entry == 'yes'
    hash[:surveyResponseId] = 'N' if entry == 'no'
    hash[:surveyResponseId] = 'E' if entry == 'English'
    hash[:surveyResponseId] = 'S' if entry == 'Spanish'
    hash[:surveyResponseId] = 'F' if entry == 'French'
    hash[:surveyResponseId] = 'G' if entry == 'German'
    hash[:surveyResponseId] = 'V' if entry == 'Vietnamese'
    @json_hash[:responses] << hash
  end
end
