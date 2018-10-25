require "rails_helper"

describe "welcome page" do
  it "should be the root and have some links" do
    visit "/"

    expect(page).to have_content("Welcome")

  end
end
