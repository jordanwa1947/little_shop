require 'rails_helper'

describe 'Admin clicks on users_page' do
  describe 'the admin sees a list of links to users' do
    before(:each) do
      @user_1 = User.create(name: 'Sherlock Holmes', address: '221 Baker street', city: 'London', state: 'oppressed',
      zip_code: '12345', email: 'AwesomeSauce@gmail.com', password: '123123')
      @user_2 = User.create(name: "Dan Hutch", address: "654 turing way", city: "Scranton", state: "Pennsylvania",
      zip_code: '50000', email: 'huchley@gmail.com', password: 'pizza@myhouse123')
      @admin = User.create(name: "Jordan Whitten", address: "8008 Awesome street", city: "South Park", state: "Colorado",
      zip_code: '12465', email: 'jawesome@gmail.com', password: '456123', role: 2)
    end
    it 'takes the admin to the user profile when clicked on' do

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit admin_users_path

      expect(page).to have_link(@user_2.name)
      click_link(@user_1.name)

      expect(current_path).to eq(admin_user_path(@user_1))
      expect(page).to have_content('Sherlock Holmes')
      expect(page).to have_content('registered_user')
      expect(page).to have_content('Address: 221 Baker street')
      expect(page).to have_content('City: London')
      expect(page).to have_content('State: oppressed')
      expect(page).to have_content('Zip Code: 12345')
      expect(page).to have_content('Email: AwesomeSauce@gmail.com')
    end

    it 'non admin users cant visitt the users index' do

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
      visit admin_users_path

      expect(page).to have_content("The page you were looking for doesn't exist.")
    end

    it 'has an enable and disable link for each user' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit admin_users_path

      click_link('Disable', match: :first)

      expect(current_path).to eq(admin_users_path)
      expect(page).to have_content("#{@user_1.name}'s account is now disabled")
      expect(User.first.status).to eq("disabled")

      click_link('Enable', match: :first)

      expect(current_path).to eq(admin_users_path)
      expect(page).to have_content("#{@user_1.name}'s account is now enabled")
      expect(User.first.status).to eq("active")
    end

    it 'keeps a user from logging in when their account is disabled' do
      user_4 = User.create(name: 'Your Mom', address: 'drewry lane', city: 'New Haven', state: 'Conecticut',
      zip_code: '12345', email: 'demure@gmail.com', password: '10000', status: 'disabled')
      visit login_path

      fill_in "Email", with: user_4.email
      fill_in "Password", with: user_4.password

      click_on "Log in"

      expect(current_path).to eq(login_path)
    end
  end
end
