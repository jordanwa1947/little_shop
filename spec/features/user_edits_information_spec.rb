require 'rails_helper'

describe 'User visits edit page' do
  describe 'User fills out form' do
    it 'updates user information' do
      visit new_user_path

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
      click_link 'Edit Info'

      expect(current_path).to eq(profile_edit_path)

      expect(find_field("name-field").value).to eq(User.last.name)
      expect(find_field("address-field").value).to eq(User.last.address)
      expect(find_field("city-field").value).to eq(User.last.city)
      expect(find_field("state-field").value).to eq(User.last.state)
      expect(find_field("zipcode-field").value).to eq(User.last.zip_code.to_s)
      expect(find_field("email-field").value).to eq(User.last.email)
      expect(find_field("password-field").value).to eq('')
      expect(find_field("confirm-field").value).to eq('')

      fill_in 'name-field', with: 'Jawesome'
      fill_in 'email-field', with: 'new-guy@yahoo.com'
      fill_in 'password-field', with: 'password5'
      fill_in 'confirm-field', with: 'password5'
      click_on 'Update User'

      expect(current_path).to eq(profile_path)
      expect(page).to have_content('Welcome, Jawesome')
      expect(page).to have_content('new-guy@yahoo.com')
      expect(page).to have_content('Your Info Was Successfully Updated!')
      expect(page).to_not have_content("example@gmail.com")
    end


    it "should fail if email address is already in use" do
      User.create(
        name: "My Name",
        address: "123 fake street",
        city: "denver",
        state: "CO",
        zip_code: 80000,
        password: "password",
        email: "email@email.com",
        role: :registered_user,
        status: :active
      )

      visit new_user_path

      fill_in "user[name]", with: "Jordan Whitten"
      fill_in "user[address]", with: "8008 Awesome street"
      fill_in "user[city]", with: "South Park"
      fill_in "user[state]", with: "CO"
      fill_in "user[zip_code]", with: "50001"
      fill_in "user[email]", with: "stan@yahoo.com"
      fill_in "user[password]", with: "123456"
      fill_in "user[password_confirmation]", with: "123456"

      click_on 'Create User'
      click_link 'Edit Info'

      expect(current_path).to eq(profile_edit_path)
      expect(find_field("name-field").value).to eq(User.last.name)
      expect(find_field("address-field").value).to eq(User.last.address)
      expect(find_field("city-field").value).to eq(User.last.city)
      expect(find_field("state-field").value).to eq(User.last.state)
      expect(find_field("zipcode-field").value).to eq(User.last.zip_code.to_s)
      expect(find_field("email-field").value).to eq(User.last.email)
      expect(find_field("password-field").value).to eq('')
      expect(find_field("confirm-field").value).to eq('')

      new_name = 'Jawesome'
      new_email = 'email@email.com'
      password = 'password'

      fill_in 'name-field', with: new_name
      fill_in 'email-field', with: new_email
      fill_in 'password-field', with: password
      fill_in 'confirm-field', with: password
      click_on 'Update User'

      expect(page).to have_content("Email has already been taken")

      expect(find_field("name-field").value).to eq(new_name)
      expect(find_field("address-field").value).to eq(User.last.address)
      expect(find_field("city-field").value).to eq(User.last.city)
      expect(find_field("state-field").value).to eq(User.last.state)
      expect(find_field("zipcode-field").value).to eq(User.last.zip_code.to_s)
      expect(find_field("email-field").value).to eq(new_email)
      expect(find_field("password-field").value).to eq('')
      expect(find_field("confirm-field").value).to eq('')
    end
  end
end
