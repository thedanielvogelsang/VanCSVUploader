require 'rails_helper'

RSpec.describe SendEmailJob, type: :job do
  it 'can queue a job' do
    ActiveJob::Base.queue_adapter = :test

    expect {SendEmailJob.perform_later
    }.to have_enqueued_job
  end
end
