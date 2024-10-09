class JobsController < ApplicationController
  before_action :set_job, only: %i[ show edit update destroy ]
  before_action :ensure_frame_response, only: %i[ new edit ]
  before_action :authorize_access, only: %i[ show ]

  def index
    @jobs = Job.within_account(current_account)
  end

  def show
  end

  def new
    @job = Job.new
  end

  def edit
  end

  def create
    @job = Job.new(job_params)
    @job.account = current_account

    respond_to do |format|
      if @job.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.prepend("jobs_container", partial: "jobs/job", locals: { job: @job })
        end
        format.html { redirect_to @job, notice: "Job was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @job.update(job_params)
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("job_#{@job.id}_row", partial: "jobs/job", locals: { job: @job }),
            turbo_stream.replace("job_#{@job.id}_detail", partial: "jobs/details", locals: { job: @job })
          ]
        end
        format.html { redirect_to @job, notice: "Job was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @job.destroy!

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove("job_#{@job.id}_row")
      end
      format.html { redirect_to jobs_path, status: :see_other, notice: "Job was successfully destroyed." }
    end
  end

  private
    def set_job
      @job = Job.find(params.expect(:id))
    end

    def job_params
      params.expect(job: [ :title, :description, :location, :status, :job_type, :location_type, :salary_budget ])
    end

    def authorize_access
      redirect_to jobs_path, alert: "Unauthorized access." if @job.account != current_account
    end
end
