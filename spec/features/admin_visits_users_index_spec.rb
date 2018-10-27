require 'rails_helper'

describe 'Admin clicks on users_page' do
  describe 'the admin sees a list of links to users' do
    it 'takes the admin to the user profile when clicked on' do
      user_1 = User.create(name: 'Sherlock Holmes', address: '221 Baker street', city: 'London', state: 'oppressed',
      zip_code: '12345', email: 'AwesomeSauce@gmail.com', password: '123123')
      user_2 = User.create(name: "Dan Hutch", address: "654 turing way", city: "Scranton", state: "Pennsylvania",
      zip_code: '50000', email: 'huchley@gmail.com', password: 'pizza@myhouse123', role: 1)
      user_3 = User.create(name: "Jordan Whitten", address: "8008 Awesome street", city: "South Park", state: "Denver",
      zip_code: '12465', email: 'jawesome@gmail.com', password: '456123', role: 2)

      visit login_path

      fill_in "Email", with: 'jawesome@gmail.com'
      fill_in "Password", with: '456123'

      click_on "Log in"
      visit admin_users_path

      expect(page).to have_link("Dan Hutch")
      click_link('Sherlock Holmes')

      expect(current_path).to eq(admin_user_path(user_1))
      expect(page).to have_content('Sherlock Holmes')
      expect(page).to have_content('registered_user')
      expect(page).to have_content('Address: 221 Baker street')
      expect(page).to have_content('City: London')
      expect(page).to have_content('State: oppressed')
      expect(page).to have_content('Zip Code: 12345')
      expect(page).to have_content('Email: AwesomeSauce@gmail.com')
    end
  end
end
