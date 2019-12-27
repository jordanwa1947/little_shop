require 'rails_helper'

describe 'admin visits merchant dashboard' do
  describe 'admin edits a merchants information' do
    it 'it edits the information and takes the admin back to the show page' do
      merchant = User.create(name: 'Sherlock Holmes', address: '221 Baker street', city: 'London', state: 'oppressed',
                             zip_code: '12345', email: 'AwesomeSauce@gmail.com', password: '123123', role: 1)
      admin = User.create(name: "Jordan Whitten", address: "8008 Awesome street", city: "South Park", state: "Colorado",
                             zip_code: '12465', email: 'jawesome@gmail.com', password: '456123', role: 2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit merchant_path(merchant)

      click_link "Edit Info"

      expect(current_path).to eq(edit_user_path(merchant))

      fill_in 'user[address]', with: 'A new fake address'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'

      click_button "Update User"

      expect(current_path).to eq(merchant_path(merchant))
    end
  end
end
