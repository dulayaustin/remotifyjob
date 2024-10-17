class ApplicantRepliesMailbox < ApplicationMailbox
  # Compose reply mail with rails conductor at http://remotifyjob.test:4000/rails/conductor/action_mailbox/inbound_emails/new
  ALIASED_USER = /reply-(.+)@remotifyjob.com/i

  before_processing :set_applicant
  before_processing :set_user

  def process
    email = build_email
    email.body = mail.parts.present? ? mail.parts[0].body.decoded : mail.decoded
    email.save!
  end

  private

    def build_email
      Email.new(
        user_id: @user.id,
        applicant_id: @applicant.id,
        subject: mail.subject,
        email_type: "inbound"
      )
    end

    def set_applicant
      @applicant = Applicant.find_by(email_address: mail.from)
    end

    def set_user
      recipient = mail.recipients.find { |r| ALIASED_USER.match?(r) }
      @user = User.find_by(email_alias: recipient[ALIASED_USER, 1])
    end
end
