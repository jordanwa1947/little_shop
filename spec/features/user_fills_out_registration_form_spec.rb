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
    it "doesn't create or log in the user but stays on the registration page and everything but the email and password fields are still filled in" do

      visit new_user_path

      name = "Jordan Whitten"
      address = "8008 Awesome street"
      city = "South Park"
      state = "Denver"
      zip = 11110
      email = "AwesomeSauce@gmail.com"
      password = "123456"

      fill_in "name-field", with: name
      fill_in "address-field", with: address
      fill_in "city-field", with: city
      fill_in "state-field", with: state
      fill_in "zipcode-field", with: zip
      fill_in "email-field", with: email
      fill_in "password-field", with: password
      fill_in "confirm-field", with: password

      click_on 'Create User'

      expect(current_path).to eq(new_user_path)
      expect(page).to have_content('Email Address already exists')
      expect(find_field("name-field").value).to eq(name)
      expect(find_field("address-field").value).to eq(address)
      expect(find_field("city-field").value).to eq(city)
      expect(find_field("state-field").value).to eq(state)
      expect(find_field("zipcode-field").value).to eq(zip.to_s)
      expect(find_field("email-field").value).to eq(nil)
      expect(find_field("password-field").value).to eq(nil)
      expect(find_field("confirm-field").value).to eq(nil)

    end
  end
end
