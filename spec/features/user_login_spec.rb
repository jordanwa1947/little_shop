require 'rails_helper'

describe 'login process' do
  describe 'user can login as registered users' do
    it 'should succeed' do
      name = "Geoffy"
      password = 'test1234'
      user = User.create(name: name, password: password)

      visit login_path

      fill_in :name, with: name
      fill_in :password, with: password
      fill_in :confirm_password, with: password
      click_on "Log in"

      expect(current_path).to eq(user_path(user))

    end
  end
end
