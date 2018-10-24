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

  end
end

describe "as a registered user" do
  it "I should see a nav bar with all visitor links plus user links" do

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
    expect(page).to have_content("Logged in as #{user.name}")

    expect(page).to_not have_content("Log In")
    expect(page).to_not have_content("Register")
  end
end
