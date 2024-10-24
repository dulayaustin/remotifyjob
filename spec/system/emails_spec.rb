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
          within "#emails_container" do
            click_link "Send email"
          end

          within "#email_form" do
            fill_in "Subject", with: "Test subject"
            find("#email_body").click.set("Test body")
            click_button "Send"
          end

          expect(page).to have_css("#emails_list", text: "Test subject")
        }.to change(Email, :count).by(+1)
      end
    end

    describe "displaying emails on applicant page" do
      let!(:email) { FactoryBot.create(:email,
                                       subject: "Test subject",
                                       user: user,
                                       applicant: applicant) }

      it "should be listed", js: true do
        sign_in user
        visit applicant_path(applicant)

        expect(page).to have_css("#emails_list", text: "Test subject")
      end

      it "should show email with from (sender) and to (receiver) when clicked", js: true do
        sign_in user
        visit applicant_path(applicant)

        within "#emails_list" do
          click_link "Test subject"
        end

        expect(page).to have_text("From: #{user.name}")
        expect(page).to have_text("To: #{applicant.name}")
      end
    end
  end
end
