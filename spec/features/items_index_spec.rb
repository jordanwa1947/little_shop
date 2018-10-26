require 'rails_helper'

#still need to build tests and implement code for links to item show page(s)

describe "items index page" do
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
      price: 100.00,
      img_url: "https://static.grainger.com/rp/s/is/image/Grainger/12N166_AS01?$mdmain$",
      inventory_count: 5,
      description: "first description",
      status: :active
    )

    @item_2 = @user_1.items.create(
      id: 2,
      name: "Second Item",
      price: 200.00,
      img_url: "https://static.grainger.com/rp/s/is/image/Grainger/12N166_AS01?$mdmain$",
      inventory_count: 10,
      description: "second description",
      status: :active
    )
  end

  it "should show all active items and details" do

    visit items_path
    expect(page).to have_content("Items for Sale")

    within("#item-entry-1") do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_1.user.name)
      expect(page).to have_content(@item_1.inventory_count)
      expect(page).to have_content(@item_1.price)
      expect(page).to_not have_content(@item_2.price)
      expect(page).to_not have_content(@item_2.name)
    end

    within("#item-entry-2") do
      expect(page).to have_content(@item_2.name)
      expect(page).to have_content(@item_2.user.name)
      expect(page).to have_content(@item_2.inventory_count)
      expect(page).to have_content(@item_2.price)
      expect(page).to_not have_content(@item_1.price)
      expect(page).to_not have_content(@item_1.name)
    end
  end
end

# Each item's name and thumbnail image are links to that item's show page
