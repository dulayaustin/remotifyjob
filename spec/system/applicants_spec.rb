require 'rails_helper'

RSpec.describe "Applicants", type: :system do
  context "as a user" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:account) { user.account }
    let!(:job) { FactoryBot.create(:job, account: account) }

    describe "creating an applicant" do
      it "is a success", js: true do
        sign_in user
        visit applicants_path

        expect {
          click_link "Add applicant"
          fill_in "First name", with: "John"
          fill_in "Last name", with: "Doe"
          fill_in "Email address", with: "john.doe@example.com"
          select job.title, from: "applicant_job_id"
          attach_file("applicant_resume", Rails.root + "public/austin_dulay_resume.pdf")
          click_button "Save"

          expect(page).to have_css("#applicants_container", text: "John Doe")
        }.to change(job.applicants, :count).by(+1)
      end

      it "got errors", js: true do
        sign_in user
        visit applicants_path

        click_link "Add applicant"
        fill_in "First name", with: ""
        fill_in "Last name", with: ""
        fill_in "Email address", with: ""
        click_button "Save"

        expect(page).to have_content("can't be blank")
      end
    end
  end
end
