class Job < ApplicationRecord
  include PgSearch::Model

  FILTER_PARAMS = %i[ query status sort].freeze

  pg_search_scope :text_search,
    against: %i[ title ],
    using: {
      tsearch: {
        any_word: true,
        prefix: true
      }
    }

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
  scope :for_status, ->(status) { status.present? ? where(status: status) : all }
  scope :search, ->(query) { query.present? ? text_search(query) : all }
  scope :sorted, ->(selection) { selection.present? ? apply_sort(selection) : apply_sort(default_sort) }

  def self.apply_sort(selection)
    return if selection.blank?
    sort, direction = selection.split("-")
    order("jobs.#{sort} #{direction}")
  end

  def self.filter(filters)
    sorted(filters["sort"])
      .for_status(filters["status"])
      .search(filters["query"])
  end
end
