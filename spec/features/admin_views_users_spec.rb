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
      expect(page).to have_content('221 Baker street')
      expect(page).to have_content('London')
      expect(page).to have_content('oppressed')
      expect(page).to have_content('12345')
      expect(page).to have_content('AwesomeSauce@gmail.com')
      expect(page).to have_link("Upgrade To Merchant")
    end

    it 'lets an admin upgrade a user' do

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit admin_user_path(@user_1)

      click_link("Upgrade To Merchant")

      upgraded_user = User.find(@user_1.id)
      expect(current_path).to eq(merchant_path(upgraded_user.id))
      expect(page).to have_content("#{@user_1.name}'s account is now a Merchant")
      expect(upgraded_user.role).to eq('merchant_user')
    end

    it 'lets an admin downgrade a user' do

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      user_1 = User.create(name: 'Sherlock Holmes', address: '221 Baker street', city: 'London', state: 'oppressed',
      zip_code: '12345', email: 'Sauce@gmail.com', password: '123123', role: 1)

      visit merchant_path(user_1)

      click_link("Downgrade To Registered User")

      downgraded_user = User.find(user_1.id)
      expect(current_path).to eq(admin_user_path(downgraded_user.id))
      expect(page).to have_content("#{user_1.name}'s account is now a Registered User")
      expect(downgraded_user.role).to eq('registered_user')
    end

    it "allows an admin to edit any user's info from the user's show page" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit admin_users_path


      expect(page).to have_link(@user_1.name)
      expect(page).to have_link(@user_2.name)
      click_link(@user_1.name)

      expect(current_path).to eq(admin_user_path(@user_1))
      expect(page).to have_content('Sherlock Holmes')
      expect(page).to have_content('registered_user')
      expect(page).to have_content('221 Baker street')

      click_link "Edit Info"
      expect(current_path).to eq(edit_user_path(@user_1))

      expect(find_field("name-field").value).to eq(@user_1.name)
      fill_in 'address-field', with: 'A new fake address'
      click_on 'Update User'

      expect(current_path).to eq(admin_user_path(@user_1))
      expect(page).to have_content('Sherlock Holmes')
      expect(page).to have_content('A new fake address')
      expect(page).to_not have_content('Address: 221 Baker street')
    end

    it "will show a user's orders index via a link from the user profile page" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      item_1 = Item.create(
        name: "Shovel",
        description: "A good way to get attention. Bring one to parties.",
        price: 16,
        img_url:        "http://www.colourbox.com/preview/7389458-682747-example-stamp.jpg",
        inventory_count: 20,
        user: @user_2
      )
      item_2 = Item.create(
        name: "Kool Aid",
        description: "Transcend to the next level! Oh Yeah!", price: 3,
        img_url: "http://www.colourbox.com/preview/7389458-682747-example-stamp.jpg",
        inventory_count: 30,
        status: 1,
        user: @user_2
      )
      item_3 = Item.create(
        name: "Possum Sweater",
        description: "Big in New Zealand.",
        price: 67,
        img_url: "http://www.colourbox.com/preview/7389458-682747-example-stamp.jpg",
        inventory_count: 40,
        user: @user_2
      )
      item_4 = Item.create(
        name: "Beef Jerky",
        description: "Good for camping trips and picnics.",
        price: 13,
        img_url: "http://www.colourbox.com/preview/7389458-682747-example-stamp.jpg",
        inventory_count: 50,
        status: 1,
        user: @user_2
      )
      order_1 = @user_1.orders.create(status: :pending)
      order_2 = @user_1.orders.create(status: :pending)
      order_3 = @user_2.orders.create(status: :pending)

      order_item_10 = OrderItem.create(
        item_id: item_4.id,
        order_id: order_3.id,
        item_quantity: 5,
        item_price: item_4.price,
        fulfilled: :false
      )
      order_item_1 = OrderItem.create(
        item_id: item_1.id,
        order_id: order_1.id,
        item_quantity: 5,
        item_price: item_1.price,
        fulfilled: :false
      )
      order_item_2 = OrderItem.create(
        item_id: item_3.id,
        order_id: order_1.id,
        item_quantity: 3,
        item_price: item_4.price,
        fulfilled: :false
      )
      order_item_3 = OrderItem.create(
        item_id: item_2.id,
        order_id: order_2.id,
        item_quantity: 7,
        item_price: item_2.price,
        fulfilled: :false
      )
      order_item_4 = OrderItem.create(
        item_id: item_3.id,
        order_id: order_2.id,
        item_quantity: 2,
        item_price: item_3.price,
        fulfilled: :false
      )

      visit admin_users_path

      expect(page).to have_link(@user_1.name)
      expect(page).to have_link(@user_2.name)
      click_link(@user_1.name)

      expect(current_path).to eq(admin_user_path(@user_1))
      expect(page).to have_content('Sherlock Holmes')

      expect(page).to have_content('registered_user')
      expect(page).to have_content('221 Baker street')

      click_on "View User Orders"
      expect(current_path).to eq(admin_user_orders_path(@user_1))
      expect(page).to have_content(item_1.name)
      expect(page).to have_content(order_item_1.item_quantity)
      expect(page).to have_content(item_2.name)
      expect(page).to have_content(order_item_3.item_quantity)
      expect(page).to_not have_content(item_4.name)

    end

    it 'non admin users cannot visit the users index' do

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
      expect(page).to have_content("#{@user_1.name}'s account is now active")
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
