class VanService
  def initialize
    @conn = Faraday.new("https://api.securevan.com/v4") do |faraday|
      faraday.headers['Content-Type'] = 'application/json'
      faraday.basic_auth(ENV['VAN_USERNAME'], ENV['VAN_API_KEY'])
      faraday.adapter Faraday.default_adapter
    end
  end

  def get
    response = @conn.get('/canvassResponses/inputTypes')
    JSON.parse(response.body, symbolize_names: true)
  end

  def post(id, survey_responses)
    @conn.post()
  end

  ## first/last + email; +address; +phone; email+address+phone;
  def find_or_create(user_response)
    user = parse(user_response)
    user.each do |t_type|
      ids = []
      response = @conn.post do |req|
        req.url "people/findOrCreate"
        req.headers['Content-Type'] = 'application/json'
        req.body = t_type.to_json
      end
      response = JSON.parse(response.body)
      binding.pry
    end
    id = sort_ids(ids)
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
                  binding.pry
    return [template1, template2, template3, template4]
  end

  def find_or_create_all_and_post(survey_responses)
    survey_response.each do |survey|
      id = find_or_create(survey)
      post(id, survey[:responses])
    end
  end

  def self.post(survey_responses)
    new.post(survey_responses)
  end
end
