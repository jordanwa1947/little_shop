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
    it "doesn't create or log in the user but stays on the registration page and everything but the email and password fields are still filled in" do

      visit new_user_path

      name = "Jordan Whitten"
      address = "8008 Awesome street"
      city = "South Park"
      state = "Denver"
      zip = 11110
      email = "AwesomeSauce@gmail.com"
      password = "123456"

      fill_in "Name", with: name
      fill_in "Address", with: address
      fill_in "City", with: city
      fill_in "State", with: state
      fill_in "Zip code", with: zip
      fill_in "Email", with: email
      fill_in "Password", with: password
      fill_in "Password confirmation", with: password

      click_on 'Create User'

      expect(current_path).to eq(new_user_path)
      expect(page).to have_content('Email Address already exists')
      expect(find_field("user_name").value).to eq(name)
      expect(find_field("user_address").value).to eq(address)
      expect(find_field("user_city").value).to eq(city)
      expect(find_field("user_state").value).to eq(state)
      expect(find_field("user_zip_code").value).to eq(zip.to_s)
      expect(find_field("user_email").value).to eq(nil)
      expect(find_field("user_password").value).to eq(nil)
      expect(find_field("user_password_confirmation").value).to eq(nil)

    end
  end
end
