class User < ApplicationRecord
  has_secure_password

  belongs_to :account
  has_many :sessions, dependent: :destroy
  has_many :emails, dependent: :destroy

  accepts_nested_attributes_for :account

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :email_address, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true

  after_create_commit :generate_email_alias

  def name
    [ first_name, last_name ].join(" ")
  end

  def internal_email_address
    "reply-#{email_alias}@remotifyjob.com"
  end

  private

    def generate_email_alias
      email_alias = "#{email_address.split("@").first}-#{id}"
      update_column(:email_alias, email_alias)
    end
end
