module ApplicantsHelper
  def applicants_sort_options
    [
      [ "Newest", "created_at-desc" ],
      [ "Oldest", "created_at-asc" ]
    ]
  end

  def applicants_job_filter_options
    Job.where(account_id: current_account.id).order(:title).pluck(:title, :id)
  end
end
