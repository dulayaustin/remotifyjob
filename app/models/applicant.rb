class Applicant < ApplicationRecord
  belongs_to :job

  validates :email_address, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_uniqueness_of :email_address, scope: :job_id, case_sensitive: false
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :stage, presence: true
  validates :status, presence: true
  validates_with ResumeValidator

  has_one_attached :resume

  enum :stage, {
    application: "application",
    interview: "interview",
    offer: "offer",
    hired: "hired"
  }

  enum :status, {
    active: "active",
    inactive: "inactive"
  }

  def name
    [ first_name, last_name ].join(" ")
  end
end
