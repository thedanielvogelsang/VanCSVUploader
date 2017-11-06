class UserMailer < ApplicationMailer
  default from: 'dr.vogelsang26@gmail.com'

  def send_summary(survey_results=[1, 2, 6])
    @survey_results = survey_results
    mail(to: 'dr.vogelsang26@gmail.com', subject: 'Import Successful')
  end

end
