require 'rails_helper'

describe 'user signs up and then logs out' do
  it 'should log out and return to root' do
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

    click_on "Log Out"
    expect(current_path).to eq(root_path)
    expect(page).to have_content("Thank you! You have been logged out.")
  end
end
