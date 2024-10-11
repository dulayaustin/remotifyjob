class Applicant < ApplicationRecord
  include PgSearch::Model

  FILTER_PARAMS = %i[ query job sort].freeze

  pg_search_scope :text_search,
    against: %i[ first_name last_name email_address ],
    using: {
      tsearch: {
        any_word: true,
        prefix: true
      }
    }

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

  scope :within_account, ->(account_id) { where(jobs: { account_id: account_id }) }
  scope :within_job, ->(job_id) { job_id.present? ? where(job_id: job_id) : all }
  scope :search, ->(query) { query.present? ? text_search(query) : all }
  scope :sorted, ->(selection) { selection.present? ? apply_sort(selection) : apply_sort(default_sort) }

  def self.apply_sort(selection)
    return if selection.blank?
    sort, direction = selection.split("-")
    order("applicants.#{sort} #{direction}")
  end

  def self.filter(filters)
    includes(:job)
      .sorted(filters["sort"])
      .within_job(filters["job"])
      .search(filters["query"])
  end

  def name
    [ first_name, last_name ].join(" ")
  end
end
