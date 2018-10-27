require 'rails_helper'

describe 'user signs up and then logs out' do
  it 'should log out and return to root' do
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
    expect(current_path).to eq(profile_path)

    click_on "Log Out"
    expect(current_path).to eq(root_path)
    expect(page).to have_content("Thank you! You have been logged out.")
  end
end
