require 'rails_helper'

RSpec.describe ApplicantRepliesMailbox, type: :mailbox do
  let!(:outbound_email) { FactoryBot.create(:email) }
  let(:user) { outbound_email.user }
  let(:applicant) { outbound_email.applicant }

  context "an applicant is replying from outbound email that was sent by user" do
    it "route email `reply-{user.email_alias}@remotifyjob.com` properly" do
      expect(ApplicantRepliesMailbox).to receive_inbound_email(to: user.internal_email_address)
    end

    describe "with valid headers" do
      let!(:mail) { Mail.new(
        from: applicant.email_address,
        to: user.internal_email_address,
        subject: "Test subject",
        body: "Test body"
      ) }

      it "generates inbound email data" do
        expect {
          process(mail)

          expect(Email.last.email_type).to eq "inbound"
          expect(Email.last.applicant_id).to eq applicant.id
          expect(Email.last.user_id).to eq user.id
          expect(Email.last.subject).to eq "Test subject"
        }.to change(Email, :count).by(+1)
      end

      it "must be delivered" do
        mail_processed = process(mail)

        expect(mail_processed).to have_been_delivered
      end
    end

    describe "with invalid headers" do
      let!(:mail) { Mail.new(
        from: applicant.email_address,
        to: user.internal_email_address,
        subject: "",
        body: "Test body"
      ) }

      it "marks email as failed when subject is blank" do
        expect {
          mail_processed = process(mail)
          expect(mail_processed).to have_failed
        }.to raise_error(/Subject can't be blank/)
      end
    end
  end
end
