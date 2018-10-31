require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'when a merchant visits their dashboard and clicks on items' do
  before(:each) do
    @user = User.create(
      name: "merch",
      address: 'fake address',
      city: 'Austin',
      state: 'oppressed',
      zip_code: '12345',
      email: 'AwesomeSauce@gmail.com',
      password: '123123',
      role: :merchant_user
    )

    @item_1 = @user.items.create(
      name: 'shovel',
      price: '2000',
      img_url: 'https://www.google.com/url?sa=i&source=images&cd=&cad=rja&uact=8&ved=2ahUKEwjhpcSPyqLeAhUU8YMKHVoiD5oQjRx6BAgBEAU&url=https%3A%2F%2Fwww.lowes.com%2Fpd%2FTruper-45-in-Wood-Long-handle-Digging-Shovel%2F3060031&psig=AOvVaw3u-wUjbXiMlHp3iuSEz6Oo&ust=1540590779700815',
      inventory_count: 5,
      description: 'we got to go and dig some holes'
    )
    @item_2 = @user.items.create(
      name: 'rope',
      price: '1000',
      img_url: 'https://www.google.com/imgres?imgurl=https%3A%2F%2Ferinrope.com%2Fwp-content%2Fuploads%2F2017%2F10%2F3-Strand-White-Nylon-Rope-300x300.jpg&imgrefurl=https%3A%2F%2Ferinrope.com%2Frope-material%2F&docid=QA4bWJwhDBTKYM&tbnid=2IIV_8EXNpM7-M%3A&vet=10ahUKEwjcvIHdzaLeAhVBpoMKHVpxAXwQMwigASgrMCs..i&w=300&h=300&bih=790&biw=1440&q=rope%20images&ved=0ahUKEwjcvIHdzaLeAhVBpoMKHVpxAXwQMwigASgrMCs&iact=mrc&uact=8',
      inventory_count: 3,
      description: 'length: 20ft')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it 'should go to the dashboard items index and show item details' do
    visit dashboard_path(@user.id)
    click_on "View My Items"

    expect(current_path).to eq(dashboard_items_path)

    expect(page).to have_content(@item_1.id)
    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(number_to_currency(@item_1.price))
    expect(page).to have_content(@item_1.inventory_count)

    click_on("Add a new item")

    expect(current_path).to eq(new_dashboard_item_path)

    expect(page).to have_content("New Item")

    visit dashboard_items_path

    click_on("Edit this item", match: :first)

    expect(current_path).to eq(edit_dashboard_item_path(@item_1.id))

    expect(page).to have_content("Edit #{@item_1.name}")

    visit dashboard_items_path
    expect(@item_1.status).to eq('active')
    expect(page).to_not have_content("Enable")
    click_on("Disable", match: :first)
    # expect(@item_1.status).to eq('disabled')
    expect(page).to have_content("#{@item_1.name} is no longer for sale")
    expect(current_path).to eq(dashboard_items_path)
    expect(page).to have_content("Enable")
    click_on("Enable", match: :first)
    expect(page).to have_content("#{@item_1.name} is now available for sale")

  end

end
