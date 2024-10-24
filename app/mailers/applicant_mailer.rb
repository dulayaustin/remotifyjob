class ApplicantMailer < ApplicationMailer
  def contact(email:)
    @email = email
    @applicant = @email.applicant
    @user = @email.user

    mail(
      to: @applicant.email_address,
      from: @user.internal_email_address,
      subject: @email.subject
    )
  end
end
