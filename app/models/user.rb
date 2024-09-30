class User < ApplicationRecord
  has_secure_password

  belongs_to :account
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :email_address, presence: true, uniqueness: true, format: URI::MailTo::EMAIL_REGEXP
  validates :first_name, presence: true
  validates :last_name, presence: true
end
