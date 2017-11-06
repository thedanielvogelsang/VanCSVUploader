class VanService
  def initialize
    @conn = Faraday.new("https://api.securevan.com/v4") do |faraday|
      faraday.headers['Content-Type'] = 'application/json'
      faraday.basic_auth(ENV['VAN_USERNAME'], ENV['VAN_API_KEY'])
      faraday.adapter Faraday.default_adapter
    end
    @successful_posts = []
    @unsuccessful_posts = []
  end

  def get
    response = @conn.get('/canvassResponses/inputTypes')
    JSON.parse(response.body, symbolize_names: true)
  end

  def post(id, survey_responses)
    response = @conn.post do |req|
      req.url "people/#{id}/canvassResponses"
      req.headers['Content-Type'] = 'application/json'
      req.body = survey_responses.to_json
    end
    response = JSON.parse(response.body, symbolize_names: true)
    # if successful, add to successful_posts
  end

  def find_or_create(user_response)
    user = parse(user_response)
    ids = []
    user.each do |t_type|
      response = @conn.post do |req|
        req.url "people/findOrCreate"
        req.headers['Content-Type'] = 'application/json'
        req.body = t_type.to_json
      end
      response = JSON.parse(response.body)
      ids << response['vanId']
    end
    id = sort_ids(ids)
  end

  def sort_ids(ids)
    if ids.compact.uniq!.count == 1
      ids.compact.uniq![0]
    else
      nil
    end
  end

  def parse(response)
    template1 = {"firstName": response[:firstName],
        "lastName": response[:lastName],
    	  "emails": [{"email": response[:email]}]}
    template2 = {"firstName": response[:firstName],
        "lastName": response[:lastName],
        "phones": [{"phoneNumber": response[:phoneNumber]}]}
    template3 = {"firstName": response[:firstName],
        "lastName": response[:lastName],
        "addresses":[{"addressLine1": response[:address],
                      "city": response[:city],
                      "stateOrProvince": response[:stateOrProvince],
                      "zipOrPostalCode": response[:zipOrPostalCode]}]}
    template4 = {"addresses":[{"addressLine1": response[:address],
                  "city": response[:city],
                  "stateOrProvince": response[:stateOrProvince],
                  "zipOrPostalCode": response[:zipOrPostalCode]}],
                  "emails": [{"email": response[:email]}],
                  "phones": [{"phoneNumber": response[:phoneNumber]}]}
    return [template1, template2, template3, template4]
  end

  def self.find_or_create_all_and_post(survey_responses)
    survey_response.each do |survey|
      id = find_or_create(survey)
      if id.nil?
        #if you can't find id, add to unsuccessful posts
        @unsuccessful_posts << survey
      else
        post(id, survey[:responses])
      end
    end
  end
end
