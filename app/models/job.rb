class Job < ApplicationRecord
  belongs_to :account

  validates :title, presence: true
  validates :location, presence: true
  validates :status, presence: true
  validates :job_type, presence: true
  validates :location_type, presence: true

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

  has_rich_text :description

  scope :within_account, ->(account) { where(jobs: { account_id: account.id }) }
end
