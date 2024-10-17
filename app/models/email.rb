class Email < ApplicationRecord
  belongs_to :applicant
  belongs_to :user

  validates :subject, presence: true
  validates :email_type, presence: true

  has_rich_text :body

  enum :email_type, {
    outbound: "outbound",
    inbound: "inbound"
  }

  scope :within_applicant, ->(applicant_id) { where(applicant_id: applicant_id) }

  after_create_commit :send_email, if: :outbound?

  def send_email
    ApplicantMailer.contact(email: self).deliver_later
  end
end
