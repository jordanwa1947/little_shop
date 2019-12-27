require 'rails_helper'

describe 'login process' do
  describe 'user can login as registered users' do
    before(:each) do
      name = "Jordan Whitten"
      address = "8008 Awesome street"
      city = "South Park"
      state = "Colorado"
      zip_code = "00001"
      @email = "AwesomeSauce@gmail.com"
      @password = "123456"
      password_confirmation = "123456"

      @user = User.create(
        name: name,
        address: address,
        city: city,
        state: state,
        zip_code: zip_code,
        email: @email,
        password: @password,
        role: :registered_user,
        status: :active)
    end

    it 'should succeed' do
      visit login_path

      fill_in "Email", with: @email
      fill_in "password-field", with: @password

      click_on "Log in"
      expect(current_path).to eq(profile_path)
    end

    it "should fail if password is incorrect" do
      visit login_path

      fill_in "Email", with: @email
      fill_in "password-field", with: "incorrect"
      click_on "Log in"
      expect(current_path).to eq(login_path)
    end

    it "should fail if email is incorrect" do
      visit login_path

      fill_in "Email", with: "wrong@email.com"
      fill_in "password-field", with: @password
      click_on "Log in"
      expect(current_path).to eq(login_path)
    end
    it "should redirect from the login path to the profile path if user is logged in" do
      admin = User.create(
        name: "admin",
        address: "admin address",
        city: "denver",
        state: "co",
        zip_code: "80222",
        email: "admin@admin.com",
        password: "admin",
        role: :admin_user,
        status: :active)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit login_path

      expect(current_path).to eq(profile_path)
      expect(page).to have_content("You are already logged in.")
    end
  end

end
