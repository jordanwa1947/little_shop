require 'rails_helper'

describe "as a visitor" do
  it "I should see a nav bar with visitor links" do

    visit '/'

    expect(page).to have_content("Return to Welcome Page")
    expect(page).to have_content("Browse All Items")
    expect(page).to have_content("See Merchants")
    expect(page).to have_content("View Cart")
    expect(page).to have_content("Items in Cart:")
    # Next to the shopping cart link I see a count of the items in my cart
    expect(page).to have_content("Log In")
    expect(page).to have_content("Register")

    expect(page).to_not have_content("My Profile")
    # Need to build out all these links!
  end
end

describe "as a registered user" do
  it "I should see a nav bar with all visitor links plus user links" do

    name = 'Reg'
    password = 'test1234'
    address = '123 Street'
    city = 'Denver'
    state = 'CO'
    zip_code = '88888'
    email = 'email@mail.com'

    reg = User.create(
      name: name,
      password: password,
      address: address,
      city: city,
      state: state,
      zip_code: zip_code,
      email: email,
      role: :registered_user,
      status: :active
    )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(reg)

    visit "/"

    expect(page).to have_content("Return to Welcome Page")
    expect(page).to have_content("Browse All Items")
    expect(page).to have_content("See Merchants")
    expect(page).to have_content("View Cart")
    expect(page).to have_content("Items in Cart:")
    # Next to the shopping cart link I see a count of the items in my cart
    expect(page).to have_content("My Profile")
    expect(page).to have_content("My Orders")
    expect(page).to have_content("Log Out")
    expect(page).to have_content("Logged-in as: #{reg.name}")

    expect(page).to_not have_content("Log In")
    expect(page).to_not have_content("Register")
    # Need to build out all these links!
  end
end

describe "as a merchant user" do
  it "I should see a nav bar with all user links plus merchant links" do

    name_1 = 'Reg'
    password_1 = 'test1234'
    address_1 = '123 Street'
    city_1 = 'Denver'
    state_1 = 'CO'
    zip_code_1 = '88888'
    email_1 = 'email2@mail.com'

    reg = User.create(
      name: name_1,
      password: password_1,
      address: address_1,
      city: city_1,
      state: state_1,
      zip_code: zip_code_1,
      email: email_1,
      role: :registered_user,
      status: :active
    )

    name = 'Merch'
    password = 'test1234'
    address = '123 Street'
    city = 'Denver'
    state = 'CO'
    zip_code = '88888'
    email = 'email@mail.com'

    merch = User.create(
      name: name,
      password: password,
      address: address,
      city: city,
      state: state,
      zip_code: zip_code,
      email: email,
      role: :merchant_user,
      status: :active
    )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merch)

    visit "/"

    expect(page).to have_content("Return to Welcome Page")
    expect(page).to have_content("Browse All Items")
    expect(page).to have_content("See Merchants")
    expect(page).to have_content("View Cart")
    expect(page).to have_content("Items in Cart:")
    # Next to the shopping cart link I see a count of the items in my cart
    expect(page).to have_content("My Profile")
    expect(page).to have_content("My Orders")
    expect(page).to have_content("Log Out")
    expect(page).to have_content("Logged-in as: #{merch.name}")
    expect(page).to have_content("Merchant Dashboard")

    expect(page).to_not have_content("Log In")
    expect(page).to_not have_content("Register")
    expect(page).to_not have_content("Logged-in as: #{reg.name}")
    # Need to build out all these links!
  end
end

describe "as an admin user" do
  it "I should see a nav bar with all merchant links plus admin links" do

    name_1 = 'Reg'
    password_1 = 'test1234'
    address_1 = '123 Street'
    city_1 = 'Denver'
    state_1 = 'CO'
    zip_code_1 = '88888'
    email_1 = 'email2@mail.com'

    reg = User.create(
      name: name_1,
      password: password_1,
      address: address_1,
      city: city_1,
      state: state_1,
      zip_code: zip_code_1,
      email: email_1,
      role: :registered_user,
      status: :active
    )

    name = 'Merch'
    password = 'test1234'
    address = '123 Street'
    city = 'Denver'
    state = 'CO'
    zip_code = '88888'
    email = 'email@mail.com'

    merch = User.create(
      name: name,
      password: password,
      address: address,
      city: city,
      state: state,
      zip_code: zip_code,
      email: email,
      role: :merchant_user,
      status: :active
    )

    name_2 = 'admin'
    password_2 = 'test1234'
    address_2 = '123 Street'
    city_2 = 'Denver'
    state_2 = 'CO'
    zip_code_2 = '88888'
    email_2 = 'email3@mail.com'

    admin = User.create(
      name: name_2,
      password: password_2,
      address: address_2,
      city: city_2,
      state: state_2,
      zip_code: zip_code_2,
      email: email_2,
      role: :admin_user,
      status: :active
    )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/"

    expect(page).to have_content("Return to Welcome Page")
    expect(page).to have_content("Browse All Items")
    expect(page).to have_content("See Merchants")
    expect(page).to have_content("View Cart")
    expect(page).to have_content("Items in Cart:")
    # Next to the shopping cart link I see a count of the items in my cart
    expect(page).to have_content("My Profile")
    expect(page).to have_content("My Orders")
    expect(page).to have_content("Log Out")
    expect(page).to have_content("Logged-in as: #{admin.name}")
    expect(page).to have_content("Admin Dashboard")
    expect(page).to have_content("View All Users")

    expect(page).to_not have_content("Log In")
    expect(page).to_not have_content("Register")
    expect(page).to_not have_content("Logged-in as: #{reg.name}")
    expect(page).to_not have_content("Logged-in as: #{merch.name}")
    # Need to build out all these links!

  end
end
