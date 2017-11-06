class SurveyConverter

  def initialize(incoming_csv)
    @json_hash = json_hash_structure
    @csv_hash = incoming_csv
  end

  def clean_for_post
    van_service_package = Hash.new
    van_service_package[:firstName] = @csv_hash[:first_name]
    van_service_package[:lastName] = @csv_hash[:last_name]
    van_service_package[:zipOrPostalCode] = clean_zipcode
    van_service_package[:phoneNumber] = clean_phone
    van_service_package[:address] = clean_address
    van_service_package[:city] = @csv_hash[:city]
    van_service_package[:stateOrProvince] = clean_state
    van_service_package[:email] = @csv_hash[:email]
    convert_me(0, @csv_hash[:surveyQuestion1])
    convert_me(1, @csv_hash[:surveyQuestion2])
    convert_me(2, @csv_hash[:surveyQuestion3])
    van_service_package[:responses] = @json_hash
    return van_service_package
  end


  def self.convert(csv_hash)
    new(csv_hash).clean_for_post
  end

  def clean_phone
    original = @csv_hash[:phoneNumber]
    convert_parenthetical(original) if original.length == 14 && original[0] == '('
    return original if original.length == 10
  end


  def convert_parenthetical(num)
    num = num.delete('-',"(",")")
    return num
  end

  def clean_state
    abbr = []
    last_3 = @csv_hash[:stateOrProvince][-3..-1]
    last_3[0..1]
  end

  def clean_zipcode
    if @csv_hash[:zipOrPostalCode].scan(/\D/).empty? && @csv_hash[:zipOrPostalCode].length == 5 || @csv_hash[:zipOrPostalCode].length == 6
      @csv_hash[:zipOrPostalCode].to_i
    else
      nil
    end
  end

  def clean_address
    address_parts = @csv_hash[:addressLine1].split('#')
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
    if !entry.nil?
      responses = entry.split(',')
      responses.each do |answer|
        @json_hash[:responses] << survey_parser(num, answer) unless nil
      end
    else
      @json_hash[:responses] << survey_parser(num, entry)
    end
  end

  def survey_parser(num, entry)
    survey_ids = [268212, 268218, 268221]
    hash = {
      "surveyQuestionId": survey_ids[num],
      "surveyResponseId": nil,
      "type": "SurveyResponse"
      }
    unless entry == nil
        hash[:surveyResponseId] = 1118839 unless entry.scan(/Knocking Doors/).empty?
        hash[:surveyResponseId] = 1118841 unless entry.scan(/Call to Voters/).empty?
        hash[:surveyResponseId] = 1118842 unless entry.scan(/Hosting Events/).empty?
        hash[:surveyResponseId] = 1118843 unless entry.scan(/Support/).empty?
        hash[:surveyResponseId] = 1118844 unless entry.scan(/m not sure but I want to do something!/).empty?
        hash[:surveyResponseId] = 1118884 if entry == 'Yes'
        hash[:surveyResponseId] = 1118885 if entry == 'No'
        hash[:surveyResponseId] = 1118873 unless entry.scan(/Amharac/).empty?
        hash[:surveyResponseId] = 1118871 unless entry.scan(/Chinese/).empty?
        hash[:surveyResponseId] = 1118866 unless entry.scan(/French/).empty?
        hash[:surveyResponseId] = 1118878 unless entry.scan(/Korean/).empty?
        hash[:surveyResponseId] = 1118864 unless entry.scan(/Spanish/).empty?
        hash[:surveyResponseId] = 1118880 unless entry.scan(/Tagalog/).empty?
        hash[:surveyResponseId] = 1118870 unless entry.scan(/Vietnamese/).empty?
        hash[:surveyResponseId] = nil if hash[:surveyResponseId].nil?
    end
    hash
  end
end
