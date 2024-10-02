class UserForm
  include ActiveModel::Model

  attr_accessor :id, :first_name, :last_name, :email_address, :password, :confirm_password, :account_attributes

  validates :email_address, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true
  validates :confirm_password, presence: true
  validates_with PasswordValidator

  attr_reader :record

  def persist
    return false unless valid?

    @record = id ? User.find(id) : User.new

    @record.assign_attributes(first_name:, last_name:, email_address:, password:)
    @record.account_attributes = account_attributes
    @record.save!
  end
end
