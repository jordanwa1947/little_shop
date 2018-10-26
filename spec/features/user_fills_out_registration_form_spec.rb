require 'rails_helper'

describe 'user visits registration page' do

  before(:each) do
    @user_1 = User.create(name: 'Sherlock Holmes', address: '221 Baker street', city: 'London', state: 'oppressed',
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

      fill_in "user[name]", with: "Jordan Whitten"
      fill_in "user[address]", with: "8008 Awesome street"
      fill_in "user[city]", with: "South Park"
      fill_in "user[state]", with: "CO"
      fill_in "user[zip_code]", with: "50001"
      fill_in "user[email]", with: "stan@yahoo.com"
      fill_in "user[password]", with: "123456"
      fill_in "user[password_confirmation]", with: "123456"
      click_on 'Create User'


      expect(page).to have_content('Jordan Whitten')
      expect(page).to have_content('8008 Awesome street')
      expect(page).to have_content('South Park')
      expect(page).to have_content('CO')
      expect(page).to have_content('50001')
      expect(page).to have_content('stan@yahoo.com')
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
