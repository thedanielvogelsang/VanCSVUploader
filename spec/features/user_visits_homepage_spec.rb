require 'rails_helper'

RSpec.feature("user visits homepage") do
  it 'and sees two buttons: Sign In and Sign Up' do
    visit('/')
    expect(page).to have_content("Sign In")
    expect(page).to have_content("Sign Up")
  end
  context 'and clicks on Sign Up' do
    it 'and sees a user sign-up form' do
      visit('/')
      click_link('Sign Up')
      expect(current_path).to eq(new_user_path)
      expect(current_path).to eq('/sign-up')
      expect(page).to have_content("Username")
      expect(page).to have_content("Password")
      expect(page).to have_content("Password Confirmation")
      expect(page).to have_button('Sign Up!')
    end
  end
  context 'and clicks on Sign In' do
    it 'sees a username and password signin form' do
      visit('/')
      click_link('Sign In')
      expect(current_path).to eq(login_path)
      expect(page).to have_content("Username")
      expect(page).to have_content("Password")
      expect(page).to have_button('Sign In!')
    end
  end
end
