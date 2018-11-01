require 'rails_helper'

describe 'admin visits merchants page' do
  before(:each) do
    @merchant_1 = User.create(name: 'Sherlock Holmes', address: '221 Baker street', city: 'London', state: 'oppressed',
    zip_code: '12345', email: 'AwesomeBoss@gmail.com', password: '123123', role: 1)
    @merchant_2 = User.create(name: "Dan Hutch", address: "654 turing way", city: "Scranton", state: "Pennsylvania",
    zip_code: '50000', email: 'huchley@gmail.com', password: 'pizza@myhouse123', role: 1, status: 'disabled')
    @admin = User.create(name: 'Jordan', address: '221 Awesome way', city: 'Tampa', state: 'oppressed',
    zip_code: '12345', email: 'AwesomeSauce@gmail.com', password: '123123', role: 2)
  end

  it 'displays all merchants' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    visit root_path

    click_link "See Merchants"

    expect(current_path).to eq(merchants_path)
    expect(page).to have_link(@merchant_1.name)
    expect(page).to have_link('Disable')
    expect(page).to have_link(@merchant_2.name)
    expect(page).to have_link('Enable')
  end

  describe 'Disable and Enable links disable/enable merchant accounts' do
    it 'disables an account' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit merchants_path
      click_link('Disable')

      expect(current_path).to eq(merchants_path)
      expect(User.find(@merchant_1.id).status).to eq('disabled')
      "#{@merchant_1.name}'s account is now disabled"
    end

    it 'enables an account' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit merchants_path
      click_link('Enable')

      expect(current_path).to eq(merchants_path)
      expect(User.find(@merchant_2.id).status).to eq('active')
      "#{@merchant_2.name}'s account is now enabled"
    end
  end

  describe 'admin visits the merchant profile' do
    it 'takes the admin to the merchant profile when clicked on' do

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit merchants_path

      click_link(@merchant_1.name)

      expect(current_path).to eq(merchant_path(@merchant_1))
      expect(page).to have_content('Sherlock Holmes')
      expect(page).to have_content('merchant_user')
      expect(page).to have_content('221 Baker street')
      expect(page).to have_content('London')
      expect(page).to have_content('oppressed')
      expect(page).to have_content('12345')
      expect(page).to have_content('AwesomeBoss@gmail.com')
      expect(page).to have_link('Edit')
    end
  end
end
