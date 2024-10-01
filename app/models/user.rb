class User < ApplicationRecord
  has_secure_password

  attr_accessor :confirm_password

  belongs_to :account
  has_many :sessions, dependent: :destroy

  accepts_nested_attributes_for :account

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :email_address, presence: true, uniqueness: true, format: URI::MailTo::EMAIL_REGEXP
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates_with PasswordValidator
end
