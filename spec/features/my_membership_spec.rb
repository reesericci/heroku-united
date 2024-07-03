require "rails_helper"

RSpec.describe "a member", type: :feature do
  before :each do
    Config.create!(attributes_for(:config))
    @member = create(:member)
  end

  it "logs in to their membership" do
    visit my_membership_path

    fill_in "Username", with: "fionahu"
    click_on "Continue →"

    page.find("[href=\"#{new_my_keycode_authentication_path}\"]").click
    expect(page).to have_current_path new_my_keycode_authentication_path

    fill_in id: "keycode_code", with: Member.find("fionahu").keycode_imprint.code.to_i
    click_on "Continue →"

    expect(page).to have_current_path(my_membership_path)
  end

  it "updates their email" do
    login_as(@member, scope: :my)
    visit my_membership_path

    fill_in "Email", with: "fionahunited@example.com"
    click_on "Update Member"

    expect(page).to have_field("Email", with: "fionahunited@example.com")
  end
end
