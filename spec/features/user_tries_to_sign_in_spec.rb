require 'rails_helper'

RSpec.feature 'User tries to sign in' do
  before(:each) do
    @user = User.create(username: 'dvog', password: '123abc')
  end
  context 'with correct data' do
    it 'and is rerouted to the CSV loading page' do
      visit('/')
      click_link('Sign In')
      expect(current_path).to eq(login_path)
      fill_in "Username", with: "dvog"
      fill_in "Password", with: '123abc'
      click_on('Sign In!')
      expect(current_path).to eq(csv_loader_path)
      expect(page).to have_content("Upload CSV:")
      expect(page).to have_button("Upload CSV to VAN")
    end
  end
  context 'with incorrect data' do
    it 'and is rerouted back to the sign in page' do
      visit('/')
      click_link('Sign In')
      expect(current_path).to eq(login_path)
      fill_in "Username", with: "dvog"
      fill_in "Password", with: 'abc123'
      click_on('Sign In!')
      expect(current_path).to eq(login_path)
      expect(page).to have_content("Username/password invalid, try again")
    end
  end
end
