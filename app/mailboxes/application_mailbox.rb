class ApplicationMailbox < ActionMailbox::Base
  # Compose reply mail with rails conductor at http://remotifyjob.test:4000/rails/conductor/action_mailbox/inbound_emails/new
  routing /reply/i => :applicant_replies
end
