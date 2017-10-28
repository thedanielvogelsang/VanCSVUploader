require 'rails_helper'

RSpec.feature("user visits homepage") do
  it 'and sees two buttons: Sign In and Sign Up' do
    visit('/')
    expect(page).to have_content("Sign In")
    expect(page).to have_content("Sign Up")
  end
  it 'and clicks on Sign Up' do
    visit('/')
    click_link('Sign Up')
    expect(current_path).to eq(new_user_path)
    expect(current_path).to eq('/sign-up')
    expect(page).to have_content("Username")
    expect(page).to have_content("Password")
    expect(page).to have_content("Password Confirmation")
    expect(page).to have_content('Sign Up')
  end
end
