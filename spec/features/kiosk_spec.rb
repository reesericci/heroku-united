require "rails_helper"

RSpec.describe "a member", type: :feature do
  before :each do
    Config.create!(attributes_for(:config))
    @member = create(:member)
  end

  it "logs in to the kiosk" do
    visit "/kiosk/member"

    fill_in "Username", with: "fionahu"
    click_on "Continue →"

    fill_in "Enter your login code", with: Member.find("fionahu").keycode_imprint.code.rotate!.to_i
    click_on "Continue →"

    expect(page).to have_current_path(edit_kiosk_member_path)
  end

  it "updates their email" do
    login_as(@member, scope: :identity)
    visit "/kiosk/member/edit"

    fill_in "Email", with: "fionahunited@example.com"
    click_on "Update Member"

    expect(page).to have_field("Email", with: "fionahunited@example.com")
  end
end
