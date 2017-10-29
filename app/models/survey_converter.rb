class SurveyConverter

  def initialize(csv_hash)
    @json_hash = {}
  end

  def post_to_van
    VanService.post_survey(@json_hash)
  end

  def self.post_to_van(csv_hash)
    new(csv_hash).post_to_van
  end
end
