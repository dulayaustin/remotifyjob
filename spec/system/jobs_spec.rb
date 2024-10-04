require 'rails_helper'

RSpec.describe "Jobs", type: :system do
  context "as a user" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:account) { user.account }

    describe "creating a job" do
      it "is a success" do
        sign_in user
        visit jobs_path

        expect {
          click_link "Create a job"
          fill_in "Title", with: "Test job"
          find("#job_description").click.set("For testing purposes only")
          fill_in "Location", with: "USA"
          select "Open", from: "job_status"
          select "Full time", from: "job_job_type"
          click_button "Save"
        }.to change(account.jobs, :count).by(+1)

        expect(page).to have_css("#flash-container", text: "Successfully created a job.")
      end
    end
  end
end
