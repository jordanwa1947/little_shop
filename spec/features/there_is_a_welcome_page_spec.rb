require "rails_helper"

describe "welcome page" do
  it "should be the root and have some links" do
    visit "/"

    find('.toggle-container').click

    expect(page).to have_content("Welcome")

  end
end
