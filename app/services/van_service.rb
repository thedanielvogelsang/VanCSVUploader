class VanService
  def initialize
    @conn = Faraday.new("https://api.securevan.com/v4/") do |faraday|
      faraday.headers['Content-Type'] = 'application/json'
      faraday.basic_auth(ENV['VAN_USERNAME'], ENV['VAN_API_KEY'])
      faraday.adapter Faraday.default_adapter
    end
  end

  def get
    response = @conn.get('canvassResponses/inputTypes')
    JSON.parse(response.body, symbolize_names: true)
  end

  def post(survey_responses)
    @conn.post()
  end

  def self.post(survey_responses)
    new.post(survey_responses)
  end
end
