require 'rails_helper'

RSpec.describe "Jobs", type: :system do
  context "as a user" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:account) { user.account }

    describe "creating a job" do
      it "is a success", js: true do
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


          expect(page).to have_css("#jobs_container", text: "Test job")
        }.to change(account.jobs, :count).by(+1)
      end

      it "got errors", js: true do
        sign_in user
        visit jobs_path

        click_link "Create a job"
        fill_in "Title", with: ""
        find("#job_description").click.set("")
        fill_in "Location", with: ""
        click_button "Save"

        expect(page).to have_content("can't be blank")
      end
    end

    describe "editing a job" do
      let!(:job) {
        FactoryBot.create(:job,
          account: account,
          title: "Test job")
      }

      it "is a success", js: true do
        sign_in user
        visit jobs_path

        find("#job_#{job.id}_row").click_link "Edit"
        fill_in "Title", with: "Edited test job"
        find('#job_description').click.set('For testing purposes only')
        select "Draft", from: "job_status"
        select "Part time", from: "job_job_type"
        fill_in "Location", with: "USA"
        click_button "Save"

        expect(page).to have_css("#jobs_container", text: "Edited test job")
      end

      it "got errors", js: true do
        sign_in user
        visit jobs_path

        find("#job_#{job.id}_row").click_link "Edit"
        fill_in "Title", with: ""
        fill_in "Location", with: ""
        click_button "Save"

        expect(page).to have_content "can't be blank"
      end
    end

    describe "deleting a job" do
      let!(:job) {
        FactoryBot.create(:job,
          account: account,
          title: "Test job")
      }

      it "is a success", js: true do
        sign_in user
        visit jobs_path

        expect {
          find("#job_#{job.id}_row").click_link "Delete"
          accept_alert

          expect(page).to_not have_css("#jobs_container", text: "Test job")
        }.to change(account.jobs, :count).by(-1)
      end
    end

    describe "viewing jobs list" do
      let!(:job) {
        FactoryBot.create(:job,
          account: account,
          title: "Job within account")
      }
      let!(:job_from_other_account) {
        FactoryBot.create(:job, title: "Job from other account")
      }

      it "should only display jobs within account" do
        sign_in user
        visit jobs_path

        expect(page).to have_css("#jobs_container", text: "Job within account")
        expect(page).to_not have_css("#jobs_container", text: "Job from other account")
      end
    end

    describe "viewing a job" do
      let!(:job) {
        FactoryBot.create(:job,
          account: account,
          title: "Job within account")
      }
      let!(:job_from_other_account) {
        FactoryBot.create(:job, title: "Job from other account")
      }

      it "can be viewed when a job is within account" do
        sign_in user
        visit job_path(job)

        expect(page).to have_text("Job within account")
      end

      it "cannot view a job from other account" do
        sign_in user
        visit job_path(job_from_other_account)

        expect(current_path).to eq jobs_path
        expect(page).to have_css("#flash-container", text: "Unauthorized access.")
      end
    end
  end
end
