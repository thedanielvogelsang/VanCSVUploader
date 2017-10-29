require 'csv'
class CSVImporter

  attr_reader :file

  def initialize(file)
    @file = file
  end

  def run
    CSV.foreach(@file, headers: true, header_converters: :symbol) do |row|
      SurveyConverter.post_to_van(player_profile_id: Player.find(row[:id]).profile.id,
                                  game_id: row[:game_id],
                                   points:  row[:points],
                                    fouls:   row[:fouls])
    end
    send_summary_email
  end

  def send_summary_email
    SendEmailJob.perform_later
  end

end
