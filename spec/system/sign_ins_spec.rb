require 'rails_helper'

RSpec.describe "Sign ins", type: :system do
  let!(:user) { FactoryBot.create(:user) }

  it "is successfully authenticated" do
    visit root_path
    click_link "Sign in"
    fill_in "Email address", with: user.email_address
    fill_in "Password", with: user.password
    click_button "Sign in"

    expect(page).to have_css("#flash-container", text: "Signed in successfully.")
    expect(current_path).to eq dashboard_path
  end
end
