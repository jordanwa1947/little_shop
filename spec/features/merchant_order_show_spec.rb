require 'rails_helper'

describe 'a merchant clicks on an individual order link' do
  before(:each) do
    @merchant_1 = User.create(name: 'Sherlock Holmes', address: '221 Baker street', city: 'London', state: 'oppressed',
      zip_code: '12345', email: 'AwesomeSauce@gmail.com', password: '123123', role: 1)
    @merchant_2 = User.create(name: 'Grandma', address: 'Muffin street', city: 'Tamp', state: 'Florida',
      zip_code: '12345', email: 'Kindly@gmail.com', password: '123123', role: 1)
    @user_1 = User.create(name: "Dan Hutch", address: "654 turing way", city: "Scranton", state: "Pennsylvania",
      zip_code: '50000', email: 'huchley@gmail.com', password: 'pizza@myhouse123')
      @order_1 = @user_1.orders.create(status: 'pending')
      @order_2 = @user_1.orders.create(status: 'pending')
      @order_3 = @user_1.orders.create(status: 'pending')

    @item_1 = @merchant_1.items.create(name: 'shovel', price: '2000', img_url: 'https://www.google.com/url?sa=i&source=images&cd=&cad=rja&uact=8&ved=2ahUKEwjhpcSPyqLeAhUU8YMKHVoiD5oQjRx6BAgBEAU&url=https%3A%2F%2Fwww.lowes.com%2Fpd%2FTruper-45-in-Wood-Long-handle-Digging-Shovel%2F3060031&psig=AOvVaw3u-wUjbXiMlHp3iuSEz6Oo&ust=1540590779700815',
      inventory_count: '5', description: 'we got to go and dig some holes')
    @item_2 = @merchant_2.items.create(name: 'rope', price: '1000', img_url: 'https://www.google.com/imgres?imgurl=https%3A%2F%2Ferinrope.com%2Fwp-content%2Fuploads%2F2017%2F10%2F3-Strand-White-Nylon-Rope-300x300.jpg&imgrefurl=https%3A%2F%2Ferinrope.com%2Frope-material%2F&docid=QA4bWJwhDBTKYM&tbnid=2IIV_8EXNpM7-M%3A&vet=10ahUKEwjcvIHdzaLeAhVBpoMKHVpxAXwQMwigASgrMCs..i&w=300&h=300&bih=790&biw=1440&q=rope%20images&ved=0ahUKEwjcvIHdzaLeAhVBpoMKHVpxAXwQMwigASgrMCs&iact=mrc&uact=8',
      inventory_count: '3', description: 'length: 20ft')
    @order_item_1 = OrderItem.create(item_id: @item_1.id, order_id: @order_1.id, item_quantity: 5, item_price: 2700)
    @order_item_2 = OrderItem.create(item_id: @item_2.id, order_id: @order_2.id, item_quantity: 3, item_price: 1000)
    @order_item_3 = OrderItem.create(item_id: @item_2.id, order_id: @order_3.id, item_quantity: 1000, item_price: 1000)
  end

  it 'takes them to the orders show page' do

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)

    visit dashboard_orders_path(@merchant_1)
    click_link('1')

    expect(current_path).to eq(order_path(@order_1))
    expect(page).to have_content("Customer Name: #{@user_1.name}")
    expect(page).to have_content("Address: #{@user_1.address}")
    expect(page).to have_link("#{@item_1.name}")
    expect(page).to have_content("Item Price: #{@item_1.price}")
    expect(page).to have_content("Item Quantity: #{@order_item_1.item_quantity}")
    expect(page).to have_link("Fulfill")
  end

  describe 'the Fulfill link is no longer visible if order quantity exceeds inventory' do
    it 'is no longer visible' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)

      visit order_path(@order_3)

      expect(current_path).to eq(order_path(@order_3))
      expect(page).to_not have_link("Fulfill")
    end
  end

  describe 'the Fulfilled link is no longer visible once order is fullfilled' do
    it 'clicks on the link' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)

      visit order_path(@order_1, merchant_id: @merchant_1.id)

      click_link("Fulfill")

      expect(current_path).to eq(order_path(@order_1.id, @merchant_1.id))
      expect(OrderItem.find(@order_item_1.id).fulfilled).to eq(true)
      expect(Item.find(@item_1.id).inventory_count).to eq(0)
      expect(page).to have_content("This Item is Fulfilled")
      expect(page).to have_content("Your Item is now Fulfilled")
      expect(page).to_not have_link("Fulfill")
    end
  end
end
