require 'rails_helper'

RSpec.feature 'User tries to sign in' do
  context 'with correct data' do
    it 'and is rerouted to the CSV loading page' do
      visit('/')
      click_link('Sign Up')
      expect(current_path).to eq(new_user_path)
      fill_in 'user[username]', with: 'BlueberryJim'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_on 'Sign Up!'
      expect(current_path).to eq(csv_loader_path)
      expect(page).to have_content("hello world")
    end
  end
  context 'with incorrect data' do
    it 'and is rerouted back to the sign up page' do
      visit('/')
      click_link('Sign Up')
      expect(current_path).to eq(new_user_path)
      fill_in 'user[username]', with: 'BlueberryJim'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password123'
      click_on 'Sign Up!'
      expect(current_path).to eq(new_user_path)
    end
  end
end
