class ApplicationMailer < ActionMailer::Base
  default from: "do-not-reply@remotify.com"
  layout "mailer"
end
