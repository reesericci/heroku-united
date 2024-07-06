require "rails_helper"

RSpec.describe "a new member", type: :feature do
  before :each do
    Config.create!(attributes_for(:config))
  end

  it "joins" do
    visit new_my_membership_path

    fill_in "Full name", with: "Fionah United"
    fill_in "Username", with: "fionahu"
    fill_in "Email", with: "fionahu@example.com"
    fill_in "Number and Street", with: "123 Main Street"
    fill_in "City", with: "Communist Utopia"
    fill_in "Province", with: "Texas"
    fill_in "Postal Code", with: "12345"
    select "United States", from: "Country"
    Extension.try(:names).keys.each do |e|
      fill_in ActiveSupport::Inflector.humanize(e.to_s), with: "Some data"
    end

    click_on "Join!"

    expect(page).to have_current_path(new_my_journey_path)
  end
end
