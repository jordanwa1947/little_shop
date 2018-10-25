require 'rails_helper'

describe 'login process' do
  describe 'user can login as registered users' do
    it 'should succeed' do


      name = "Jordan Whitten"
      address = "8008 Awesome street"
      city = "South Park"
      state = "Colorado"
      zip_code = "00001"
      email = "AwesomeSauce@gmail.com"
      password = "123456"
      password_confirmation = "123456"

      user = User.create(
        name: name,
        address: address,
        city: city,
        state: state,
        zip_code: zip_code,
        email: email,
        password: password,
        role: :registered_user,
        status: :active)
      visit login_path

      fill_in "Email", with: email
      fill_in "Password", with: password

      click_on "Log in"
      expect(current_path).to eq(user_path(user))

    end
  end
end
