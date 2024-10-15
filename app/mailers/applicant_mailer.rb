class ApplicantMailer < ApplicationMailer
  def contact(email:)
    @email = email
    @applicant = @email.applicant
    @user = @email.user

    mail(
      to: @applicant.email_address,
      from: "reply-#{@user.email_alias}@remotifyjob.com",
      subject: @email.subject
    )
  end
end
