class JobsController < ApplicationController
  before_action :set_job, only: %i[ show edit update destroy ]
  before_action :ensure_frame_response, only: %i[ new edit ]

  # GET /jobs or /jobs.json
  def index
    @jobs = Job.all
  end

  # GET /jobs/1 or /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs or /jobs.json
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

  # PATCH/PUT /jobs/1 or /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("job_#{@job.id}", partial: "jobs/job", locals: { job: @job })
        end
        format.html { redirect_to @job, notice: "Job was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1 or /jobs/1.json
  def destroy
    @job.destroy!

    respond_to do |format|
      format.html { redirect_to jobs_path, status: :see_other, notice: "Job was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def job_params
      params.expect(job: [ :title, :description, :location, :status, :job_type ])
    end
end
