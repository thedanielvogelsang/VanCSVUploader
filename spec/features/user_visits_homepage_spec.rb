require 'rails_helper'

RSpec.feature("user visits homepage") do
  it 'and sees two buttons: Sign In and Sign Up' do
    visit('/')
    expect(page).to have_content("Sign In")
    expect(page).to have_content("Sign Up")
  end
end
