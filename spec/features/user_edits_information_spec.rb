require 'rails_helper'

describe 'User visits edit page' do
  describe 'User fills out form' do
    it 'updates user information' do
      visit new_user_path

      fill_in "Name", with: "Jordan Whitten"
      fill_in "Address", with: "8008 Awesome street"
      fill_in "City", with: "South Park"
      fill_in "State", with: "Denver"
      fill_in "Zip code", with: "50001"
      fill_in "Email", with: "example@gmail.com"
      fill_in "Password", with: "123456"
      fill_in "Password confirmation", with: "123456"

      click_on 'Create User'
      click_link 'Edit Info'

      expect(current_path).to eq(edit_user_path(User.last))

      fill_in 'Name', with: 'Jawesome'
      fill_in 'Email', with: 'new-guy@yahoo.com'
      click_on 'Update User'

      expect(current_path).to eq(profile_path)
      expect(page).to have_content('Welcome, Jawesome')
      expect(page).to have_content('new-guy@yahoo.com')
      expect(page).to have_content('Your Info Was Successfully Updated!')
      expect(page).to_not have_content("example@gmail.com")
      expect(page).to_not have_field('Password')
    end
  end
end
