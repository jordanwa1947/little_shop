require 'rails_helper'

describe 'user sees statistics on orders' do
  describe 'registered user clicks on orders' do
    it 'takes the user to their orders page and they can cancel orders' do
      user_1 = User.create(name: 'Jordan', address: '221 Awesome way', city: 'Tampa', state: 'oppressed',
                            zip_code: '12345', email: 'AwesomeSauce@gmail.com', password: '123123')
      order_1 = user_1.orders.create
      order_2 = user_1.orders.create

      item_1 = user_1.items.create(name: 'shovel', price: '2000', img_url: 'https://www.google.com/url?sa=i&source=images&cd=&cad=rja&uact=8&ved=2ahUKEwjhpcSPyqLeAhUU8YMKHVoiD5oQjRx6BAgBEAU&url=https%3A%2F%2Fwww.lowes.com%2Fpd%2FTruper-45-in-Wood-Long-handle-Digging-Shovel%2F3060031&psig=AOvVaw3u-wUjbXiMlHp3iuSEz6Oo&ust=1540590779700815',
        inventory_count: '5', description: 'we got to go and dig some holes')
      item_2 = user_1.items.create(name: 'rope', price: '1000', img_url: 'https://www.google.com/imgres?imgurl=https%3A%2F%2Ferinrope.com%2Fwp-content%2Fuploads%2F2017%2F10%2F3-Strand-White-Nylon-Rope-300x300.jpg&imgrefurl=https%3A%2F%2Ferinrope.com%2Frope-material%2F&docid=QA4bWJwhDBTKYM&tbnid=2IIV_8EXNpM7-M%3A&vet=10ahUKEwjcvIHdzaLeAhVBpoMKHVpxAXwQMwigASgrMCs..i&w=300&h=300&bih=790&biw=1440&q=rope%20images&ved=0ahUKEwjcvIHdzaLeAhVBpoMKHVpxAXwQMwigASgrMCs&iact=mrc&uact=8',
        inventory_count: '3', description: 'length: 20ft')
      order_item_1 = OrderItem.create(item_id: item_1.id, order_id: order_1.id, item_quantity: 5, item_price: 2700, fulfilled?: :false)
      order_item_2 = OrderItem.create(item_id: item_2.id, order_id: order_2.id, item_quantity: 3, item_price: 1000, fulfilled?: :false)


      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit profile_path

      click_link 'My Orders'

      expect(current_path).to eq(profile_orders_path)
      expect(page).to have_content('shovel')
      expect(page).to have_content('$2,700.00')
      expect(page).to have_content('5')
      expect(page).to have_content('we got to go and dig some holes')
      expect(page).to have_content('rope')
      expect(page).to have_content('$1,000.00')
      expect(page).to have_content('3')
      expect(page).to have_content('length: 20ft')

      click_on("Cancel Order", match: :first)
      visit profile_orders_path
      expect(page).to have_content("cancelled")
    end
  end

  describe 'a user has no orders' do
    it "the nav bar doesn't display the 'My Orders' link" do
      user_1 = User.create(name: 'Jordan', address: '221 Awesome way', city: 'Tampa', state: 'oppressed',
                            zip_code: '12345', email: 'AwesomeSauce@gmail.com', password: '123123')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit profile_path

      expect(page).to_not have_link('My Orders')
    end
  end
end
