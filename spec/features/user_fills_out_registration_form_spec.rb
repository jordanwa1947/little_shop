require 'rails_helper'

describe 'user visits registration page' do
  describe 'user fills out registration' do
    it 'logs the new user in' do
      visit new_user_path

      expect(current_path).to eq(new_user_path)

      fill_in "Name", with: "Jordan Whitten"
      fill_in "Address", with: "8008 Awesome street"
      fill_in "City", with: "South Park"
      fill_in "State", with: "Denver"
      fill_in "Zip code", with: "50001"
      fill_in "Email", with: "example@gmail.com"
      fill_in "Password", with: "123456"
      fill_in "Password confirmation", with: "123456"

      click_on 'Create User'

      expect(current_path).to eq(profile_path)
      expect(page).to have_content('Welcome, Jordan Whitten')
      expect(page).to have_content('Address: 8008 Awesome street')
      expect(page).to have_content('City: South Park')
      expect(page).to have_content('State: Denver')
      expect(page).to have_content('Zip Code: 50001')
      expect(page).to have_content('Email: example@gmail.com')
      expect(page).to have_link('Edit Info')
    end
  end

  describe 'user enters email address already in use' do
    it "doesn't submit the form but stays on the registration page" do
      User.create(name: 'Sherlock Holmes', address: '221 Baker street', city: 'London', state: 'oppressed',
      zip_code: '12345', email: 'AwesomeSauce@gmail.com', password: '123123')

      visit new_user_path

      fill_in "Name", with: "Jordan Whitten"
      fill_in "Address", with: "8008 Awesome street"
      fill_in "City", with: "South Park"
      fill_in "State", with: "Denver"
      fill_in "Zip code", with: "50001"
      fill_in "Email", with: "AwesomeSauce@gmail.com"
      fill_in "Password", with: "123456"
      fill_in "Password confirmation", with: "123456"

      click_on 'Create User'

      expect(current_path).to eq(users_path)
      expect(page).to have_content('Email Address already exists')
    end
  end
end
