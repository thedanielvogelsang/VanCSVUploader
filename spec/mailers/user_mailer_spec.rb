require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'email_summary' do

  let(:mail) { described_class.send_summary.deliver_now}

    it "renders the subject" do
      expect(mail.subject).to eq('Import Successful')
    end

    it "render the receiver email" do
      expect(mail.to).to eq(["dr.vogelsang26@gmail.com"])
    end
  end
end
