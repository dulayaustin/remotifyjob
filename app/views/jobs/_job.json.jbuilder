json.extract! job, :id, :account_id, :title, :location, :status, :job_type, :created_at, :updated_at
json.url job_url(job, format: :json)
