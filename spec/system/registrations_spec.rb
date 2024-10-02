require 'rails_helper'

RSpec.describe "Registrations", type: :system do
  before do
    visit root_path
    click_link "Sign in"
    click_link "Sign up for free"
  end

  context "as a user" do
    it "successfully sign up a user" do
      expect(page).to have_content "Sign up to RemotifyJob"

      expect {
        fill_in "First name", with: "John"
        fill_in "Last name", with: "Doe"
        fill_in "Email address", with: "john.doe@example.com"
        fill_in "Password", with: "password"
        fill_in "Confirm password", with: "password"
        fill_in "Company name", with: "Sample Company"
        click_button "Sign up"
      }.to change(User, :count).by(+1)

      expect(page).to have_content "Successfully sign up"
      expect(current_path).to eq dashboard_path
      expect(User.first.account.name).to eq "Sample Company"
    end
  end

  context "signing up got errors" do
    it "is invalid when all fields are blank" do
      fill_in "First name", with: ""
      fill_in "Last name", with: ""
      fill_in "Email address", with: ""
      fill_in "Password", with: ""
      fill_in "Confirm password", with: ""
      fill_in "Company name", with: ""
      click_button "Sign up"

      expect(page).to have_content "can't be blank"
      expect(current_path).to eq new_registration_path
    end

    it "is invalid when password and confirm password does not match" do
      fill_in "Password", with: "password"
      fill_in "Confirm password", with: "incorrect_password"
      click_button "Sign up"

      expect(page).to have_content "Password does not match"
      expect(current_path).to eq new_registration_path
    end

    it "is invalid when email address format was incorrect" do
      fill_in "Password", with: "test.com"
      click_button "Sign up"

      expect(page).to have_content "Email address is invalid"
      expect(current_path).to eq new_registration_path
    end
  end
end
