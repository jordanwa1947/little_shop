require 'rails_helper'

describe 'user visit registration page' do

  before(:each) do
    @user_1 = User.create(name: 'Sherlock Holmes', address: '221 Baker street', city: 'London', state: 'opressed',
    zip_code: '12345', email: 'AwesomeSauce@gmail.com', password: '123123')

    @user_2 = User.create(name: "Dan Hutch", address: "654 turing way", city: "Scranton", state: "Pennsylvania",
    zip_code: '50000', email: 'huchley@gmail.com', password: 'pizza@myhouse123', role: 2)

    @user_3 = User.create(name: "Jordan Whitten", address: "8008 Awesome street", city: "South Park", state: "Denver",
      zip_code: '12465', email: 'jawesome@gmail.com', password: '456123', role: 1)
  end

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

      visit new_user_path

      fill_in "Name", with: "Jordan Whitten"
      fill_in "Address", with: "8008 Awesome street"
      fill_in "City", with: "South Park"
      fill_in "State", with: "Denver"
      fill_in "Zip code", with: "00001"
      fill_in "Email", with: "AwesomeSauce@gmail.com"
      fill_in "Password", with: "123456"
      fill_in "Password confirmation", with: "123456"

      click_on 'Create User'

      expect(current_path).to eq(new_user_path)
      expect(page).to have_content('Email Address already exists')
    end
  end
end
