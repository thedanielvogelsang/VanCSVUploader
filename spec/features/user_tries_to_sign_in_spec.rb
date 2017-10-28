require 'rails_helper'

RSpec.feature 'User tries to sign in' do
  context 'with correct data' do
    it 'and is rerouted to the CSV loading page' do
      visit('/')
      click_link('Sign In')
      expect(current_path).to eq(login_path)
      fill_in "Username", with: "dvog"
      fill_in "Password", with: '123abc'
      click_on('Sign In!')
      expect(current_path).to eq(csv_loader_path)
    end
  end
end
