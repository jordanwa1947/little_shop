require 'rails_helper'

describe 'admin visits their dashboard' do
  it 'shows stats for all merchants' do
    merchant_1 = User.create(name: 'Sherlock Holmes', address: '221 Baker street', city: 'London', state: 'oppressed',
                           zip_code: '12345', email: 'AwesomeSauce@gmail.com', password: '123123', role: 1)
    merchant_2 = User.create(name: 'Grandma', address: 'Muffin street', city: 'Tamp', state: 'Florida',
                           zip_code: '12345', email: 'Kindly@gmail.com', password: '123123', role: 1)
    user_1 = User.create(name: "Dan Hutch", address: "654 turing way", city: "Scranton", state: "Pennsylvania",
                         zip_code: '50000', email: 'huchley@gmail.com', password: 'pizza@myhouse123')
    user_2 = User.create(name: "Geoff", address: "123 challeger way", city: "San Diego", state: "California",
                         zip_code: '55500', email: 'KingGeoffery@gmail.com', password: 'OpenSesame')
    user_3 = User.create(name: "Mary had a little lamb", address: "big rock", city: "The middle of now where", state: "Utah",
                         zip_code: '99999', email: 'SnowWhiteFleece@gmail.com', password: 'thirsty')
    admin = User.create(name: "Jordan Whitten", address: "8008 Awesome street", city: "South Park", state: "Colorado",
                        zip_code: '12465', email: 'jawesome@gmail.com', password: '456123', role: 2)

    order_1 = user_1.orders.create(status: 'pending')
    order_2 = user_1.orders.create(status: 'pending')
    order_3 = user_2.orders.create(status: 'pending')
    order_4 = user_2.orders.create(status: 'pending')
    order_5 = user_3.orders.create(status: 'pending')

    item_1 = merchant_1.items.create(name: 'shovel', price: '2000', img_url: 'https://www.google.com/url?sa=i&source=images&cd=&cad=rja&uact=8&ved=2ahUKEwjhpcSPyqLeAhUU8YMKHVoiD5oQjRx6BAgBEAU&url=https%3A%2F%2Fwww.lowes.com%2Fpd%2FTruper-45-in-Wood-Long-handle-Digging-Shovel%2F3060031&psig=AOvVaw3u-wUjbXiMlHp3iuSEz6Oo&ust=1540590779700815',
                                   inventory_count: '500', description: 'we got to go and dig some holes')
    item_2 = merchant_2.items.create(name: 'rope', price: '1000', img_url: 'https://www.google.com/imgres?imgurl=https%3A%2F%2Ferinrope.com%2Fwp-content%2Fuploads%2F2017%2F10%2F3-Strand-White-Nylon-Rope-300x300.jpg&imgrefurl=https%3A%2F%2Ferinrope.com%2Frope-material%2F&docid=QA4bWJwhDBTKYM&tbnid=2IIV_8EXNpM7-M%3A&vet=10ahUKEwjcvIHdzaLeAhVBpoMKHVpxAXwQMwigASgrMCs..i&w=300&h=300&bih=790&biw=1440&q=rope%20images&ved=0ahUKEwjcvIHdzaLeAhVBpoMKHVpxAXwQMwigASgrMCs&iact=mrc&uact=8',
                                   inventory_count: '300', description: 'length: 20ft')
    order_item_2 = OrderItem.create(item_id: item_1.id, order_id: order_3.id, item_quantity: 3, item_price: 1000, fulfilled: :false)
    order_item_2 = OrderItem.create(item_id: item_2.id, order_id: order_4.id, item_quantity: 5, item_price: 2000, fulfilled: :false)
    order_item_2 = OrderItem.create(item_id: item_1.id, order_id: order_4.id, item_quantity: 4, item_price: 1000, fulfilled: :false)
    order_item_2 = OrderItem.create(item_id: item_2.id, order_id: order_4.id, item_quantity: 9, item_price: 1000, fulfilled: :false)
    order_item_2 = OrderItem.create(item_id: item_2.id, order_id: order_1.id, item_quantity: 6, item_price: 1000, fulfilled: :false)
    order_item_1 = OrderItem.create(item_id: item_1.id, order_id: order_1.id, item_quantity: 1, item_price: 2000, fulfilled: :false)
    order_item_2 = OrderItem.create(item_id: item_1.id, order_id: order_2.id, item_quantity: 2, item_price: 2000, fulfilled: :false)
    order_item_2 = OrderItem.create(item_id: item_2.id, order_id: order_2.id, item_quantity: 7, item_price: 1000, fulfilled: :false)
    order_item_2 = OrderItem.create(item_id: item_2.id, order_id: order_2.id, item_quantity: 8, item_price: 1000, fulfilled: :false)
    order_item_2 = OrderItem.create(item_id: item_2.id, order_id: order_5.id, item_quantity: 9, item_price: 1000, fulfilled: :false)


    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit root_path
    click_link("Admin Dashboard")

    expect(current_path).to eq(dashboard_path(admin))
    expect(page).to have_content('Admin Dashboard')

#     top 3 states where orders were shipped
# - top 3 cities in each state where orders were shipped
# - top 3 most active users by largest total order spending
# - top 3 orders by quantity of items
# - top 3 selling merchants
  end
end
