class EmailsController < ApplicationController
  before_action :set_applicant
  before_action :set_email, only: [ :show ]

  def index
    @emails = Email.within_applicant(@applicant.id).with_rich_text_body.order(created_at: :desc)
  end

  def show
    @user = @email.user
    @applicant = @email.applicant
  end

  def new
    @email = Email.new
  end

  def create
    @email = Email.new(email_params)
    @email.applicant = @applicant
    @email.user = current_user
    @email.email_type = "outbound"

    respond_to do |format|
      if @email.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.prepend("emails_list", partial: "emails/email", locals: { email: @email, applicant: @applicant })
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_email
    @email = Email.find(params[:id])
  end

  def set_applicant
    @applicant = Applicant.find(params[:applicant_id])
  end

  def email_params
    params.require(:email).permit(:subject, :body)
  end
end
