require 'rails_helper'

describe 'user visit registration page' do
  describe 'user fills out registration' do
    it 'logs the new user in' do
      visit new_user_path

      expect(current_path).to eq(new_user_path)

      fill_in "Name", with: "Jordan Whitten"
      fill_in "Address", with: "Awesome street"
      fill_in "City", with: "South Park"
      fill_in "State", with: "Denver"
      fill_in "Zip code", with: "00001"
      fill_in "Email", with: "AwesomeSauce@gmail.com"
      fill_in "Password", with: "123456"
      fill_in "Password confirmation", with: "123456"

      click_on 'Create User'

      expect(page).to have_content('Welcome, Jordan Whitten')
    end
  end
end
