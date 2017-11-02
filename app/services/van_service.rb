class VanService
  def initialize
    @conn = Faraday.new(url: "https://api.securevan.com/v4/") do |faraday|
      faraday.headers['Content-Type'] = 'application/json'
      faraday.basic_auth(ENV['USERNAME'], ENV['VAN_API_KEY'])
  end

  def post_to_van(survey_responses)
    
  end

  def self.post_to_van(survey_responses)
    new.post_to_van(survey_responses)
  end
end
