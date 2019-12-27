require 'rails_helper'

describe 'user visits registration page' do
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

      User.create(
        name: 'Sherlock Holmes',
        address: '221 Baker street',
        city: 'London',
        state: 'oppressed',
        zip_code: '12345',
        email: 'AwesomeSauce@gmail.com',
        password: '123123'
      )

      visit new_user_path

      name = "Jordan Whitten"
      address = "8008 Awesome street"
      city = "South Park"
      state = "Denver"
      zip = 11110
      email = "AwesomeSauce@gmail.com"
      password = "123456"

      fill_in "user[name]", with: name
      fill_in "user[address]", with: address
      fill_in "user[city]", with: city
      fill_in "user[state]", with: state
      fill_in "user[zip_code]", with: zip
      fill_in "user[email]", with: email
      fill_in "user[password]", with: password
      fill_in "user[password_confirmation]", with: password

      click_on 'Create User'

      expect(current_path).to eq(new_user_path)
      expect(page).to have_content('Email Address already exists')
      expect(find_field("user[name]").value).to eq(name)
      expect(find_field("user[address]").value).to eq(address)
      expect(find_field("user[city]").value).to eq(city)
      expect(find_field("user[state]").value).to eq(state)
      expect(find_field("user[zip_code]").value).to eq(zip.to_s)
      expect(find_field("user[email]").value).to eq('')
      expect(find_field("user[password]").value).to eq('')
      expect(find_field("user[password_confirmation]").value).to eq('')
    end
  end
end
