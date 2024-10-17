require "rails_helper"

RSpec.describe ApplicantMailer, type: :mailer do
  describe "contact" do
    let!(:email) { FactoryBot.create(:email, email_type: "outbound") }
    let!(:mail) { ApplicantMailer.contact(email: email) }

    it "renders the headers" do
      expect(mail.subject).to eq(email.subject)
      expect(mail.to).to eq([ email.applicant.email_address ])
      expect(mail.from).to eq([ "reply-#{email.user.email_alias}@remotifyjob.com" ])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(email.body.to_plain_text)
    end
  end
end
