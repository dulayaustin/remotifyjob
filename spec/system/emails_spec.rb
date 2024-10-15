require 'rails_helper'

RSpec.describe "Emails", type: :system do
  context "as a user" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:account) { user.account }
    let!(:job) { FactoryBot.create(:job, account: account) }
    let!(:applicant) { FactoryBot.create(:applicant, job: job) }

    describe "sending an email to applicant" do
      it "is a success", js: true do
        sign_in user
        visit applicant_path(applicant)

        expect {
          find("#emails_container").click_link "Send email"
          fill_in "Subject", with: "Test subject"
          find("#email_body").click.set("Test body")
          click_button "Send"

          expect(page).to have_css("#emails_list", text: "Test subject")
        }.to change(Email, :count).by(+1)
      end
    end
  end
end
