require 'rails_helper'

RSpec.describe Applicant, type: :model do
  describe "associations" do
    it { should belong_to(:job) }
  end

  describe "validations" do
    context "for uniqueness of email address" do
      let!(:job) { FactoryBot.create(:job) }
      let!(:existing_applicant) { FactoryBot.create(:applicant, job_id: job.id, email_address: "test@example.com") }

      it { should validate_uniqueness_of(:email_address).scoped_to(:job_id).case_insensitive }
    end
    it { should validate_presence_of(:email_address) }
    it { should allow_value("user@example.com").for(:email_address) }
    it { should_not allow_value("user.example").for(:email_address).with_message(/invalid/) }

    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:stage) }
    it { should validate_presence_of(:status) }

    context "for resume attachment" do
      it "is invalid without uploaded file" do
        applicant = Applicant.new(resume: nil)
        applicant.valid?

        expect(applicant.errors[:resume]).to include("no file added")
      end

      it "is valid only for pdf file type" do
        applicant = Applicant.new(resume: File.new("#{Rails.root}/public/austin_dulay_resume.pdf"))

        expect(applicant.resume.content_type).to eq "application/pdf"
      end

      it "is invalid when file type is not pdf" do
        applicant = Applicant.new(resume: File.new("#{Rails.root}/public/robots.txt"))
        applicant.valid?

        expect(applicant.errors[:resume]).to include("accepts pdf file type only")
      end
    end

    it { should have_one_attached(:resume) }

    it do
      should define_enum_for(:stage)
        .with_values(
          application: "application",
          interview: "interview",
          offer: "offer",
          hired: "hired"
        ).backed_by_column_of_type(:string)
    end

    it do
      should define_enum_for(:status)
        .with_values(
          active: "active",
          inactive: "inactive"
        ).backed_by_column_of_type(:string)
    end
  end
end
