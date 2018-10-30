require 'rails_helper'

RSpec.describe 'cart checkout and logout' do

  before(:each) do
    name_1 = "First User"
    address_1 = "123 Street"
    city_1 = "Denver"
    state_1 = "CO"
    zip_code_1 = 80000
    password_1 = "password1"
    email_1 = "e@mail.com"

    @name_2 = "Custy"
    @address_2 = "456 Lane"
    @city_2 = "Austin"
    @state_2 = "TX"
    @zip_code_2 = 33333
    @password_2 = "password2"
    @email_2 = "custy@mail.com"

    @customer = User.create(
      name: @name_2,
      address: @address_2,
      city: @city_2,
      state: @state_2,
      zip_code: @zip_code_2,
      password: @password_2,
      email: @email_2,
      role: :registered_user,
      status: :active
    )

    @user_1 = User.create(
      name: name_1,
      address: address_1,
      city: city_1,
      state: state_1,
      zip_code: zip_code_1,
      password: password_1,
      email: email_1,
      role: :merchant_user,
      status: :active
    )

    @item_1 = @user_1.items.create(
      id: 1,
      name: "First Item",
      price: 100,
      img_url: "https://static.grainger.com/rp/s/is/image/Grainger/12N166_AS01?$mdmain$",
      inventory_count: 5,
      description: "first description",
      status: :active
    )

    @item_2 = @user_1.items.create(
      id: 2,
      name: "Second Item",
      price: 200,
      img_url: "https://static.grainger.com/rp/s/is/image/Grainger/12N166_AS01?$mdmain$",
      inventory_count: 10,
      description: "second description",
      status: :active
    )
  end

  it 'creates an order and order items when a user checks out' do

    visit login_path

    fill_in "Email", with: @email_2
    fill_in "Password", with: @password_2

    click_on "Log in"
    expect(current_path).to eq(profile_path)

    visit item_path(1)
    click_on "ADD TO CART"
    expect(current_path).to eq(item_path(1))

    visit cart_path

    click_on "Checkout"

    expect(current_path).to eq(profile_orders_path(@customer))

    expect(@customer.orders.size).to eq(1)
    expect(@customer.orders.last.order_items.size).to eq(1)

  end

  it "clears a user's cart when the user logs out" do
    visit login_path

    fill_in "Email", with: @email_2
    fill_in "Password", with: @password_2

    click_on "Log in"
    expect(current_path).to eq(profile_path)

    visit item_path(1)
    click_on "ADD TO CART"

    visit cart_path

    expect(page).to have_content(@item_1.name)

    click_on "Log Out"

    expect(current_path).to eq(root_path)

    click_on "Log In"

    fill_in "Email", with: @email_2
    fill_in "Password", with: @password_2

    click_on "Log in"
    expect(current_path).to eq(profile_path)

    visit cart_path

    expect(page).to_not have_content(@item_1.name)
  end

  it "can empty the cart and won't checkout with an empty cart" do
    visit login_path

    fill_in "Email", with: @email_2
    fill_in "Password", with: @password_2

    click_on "Log in"
    expect(current_path).to eq(profile_path)

    visit item_path(1)
    click_on "ADD TO CART"

    visit cart_path

    expect(page).to have_content(@item_1.name)

    click_on "Empty Cart"

    expect(current_path).to eq(cart_path)
    expect(page).to_not have_content(@item_1.name)
    expect(page).to have_content("You have no items in your cart")

    click_on "Checkout"

    expect(current_path).to eq(cart_path)
    expect(page).to have_content("You have no items in your cart")




  end

end
