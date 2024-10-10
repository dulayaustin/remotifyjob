require 'rails_helper'

RSpec.describe "Sign outs", type: :system do
  let!(:user) { FactoryBot.create(:user) }

  it "is successfully signed out" do
    sign_in user

    find("#user-menu-button").click()
    click_button "Sign out", match: :first

    expect(page).to have_button("Sign in")
  end
end
