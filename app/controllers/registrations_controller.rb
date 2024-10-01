class RegistrationsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
    @user = User.new
    @user.build_account
  end

  def create
    user = User.new(user_params)
    if user.save
      start_new_session_for user
      redirect_to after_authentication_url
    else
      redirect_to new_registration_url, alert: user.errors.full_messages.to_sentence
    end
  end

  private

  def user_params
    params.require(:user).permit(:email_address, :password, :confirm_password, :first_name, :last_name, account_attributes: [ :name ])
  end
end
