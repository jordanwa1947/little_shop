require 'rails_helper'

RSpec.describe Cart do

  before(:each) do
    name_1 = "First User"
    address_1 = "123 Street"
    city_1 = "Denver"
    state_1 = "CO"
    zip_code_1 = 80000
    password_1 = "password1"
    email_1 = "e@mail.com"

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

  it ".count_all" do
    cart = Cart.new({
      "1" => 2,
      "2" => 3})
    expect(cart.count_all).to eq(5)
  end

  it ".add_item" do
    cart = Cart.new({"1" => 2, "2" => 3})
    cart.add_item(1)
    cart.add_item(2)

    expect(cart.contents).to eq({
      '1' => 3,
      '2' => 4})
  end

  it ".subtract_item" do
    cart = Cart.new({"1" => 2, "2" => 3})
    cart.subtract_item(1)
    cart.subtract_item(2)

    expect(cart.contents).to eq({
      '1' => 1,
      '2' => 2
      })

    cart.subtract_item(1)

    expect(cart.contents).to eq({
      '2' => 2
      })
  end

  it ".quantity" do
    cart = Cart.new({"1" => 2, "2" => 3})

    expect(cart.quantity(1)).to eq(2)
    expect(cart.quantity(2)).to eq(3)
  end

  it ".total_price" do
    cart = Cart.new({"1" => 2, "2" => 3})

    expect(cart.total_price).to eq(800)
  end

  it ".merchant" do
    cart = Cart.new({"1" => 2, "2" => 3})
    expect(cart.merchant(1)).to eq(@user_1)
  end
end
