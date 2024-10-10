class Job < ApplicationRecord
  belongs_to :account

  has_many :applicants, dependent: :destroy

  validates :title, presence: true
  validates :location, presence: true
  validates :status, presence: true
  validates :job_type, presence: true
  validates :location_type, presence: true

  has_rich_text :description

  enum :status, {
    draft: "draft",
    open: "open",
    closed: "closed"
  }

  enum :job_type, {
    full_time: "full_time",
    part_time: "part_time",
    contract: "contract",
    internship: "internship"
  }

  enum :location_type, {
    remote: "remote",
    hybrid: "hybrid",
    on_site: "on_site"
  }

  scope :within_account, ->(account_id) { where(account_id: account_id) }
end
