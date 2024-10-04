class Job < ApplicationRecord
  belongs_to :account

  validates :account_id, presence: true
  validates :title, presence: true
  validates :location, presence: true
  validates :status, presence: true
  validates :job_type, presence: true

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

  has_rich_text :description
end
