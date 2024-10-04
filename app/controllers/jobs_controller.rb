class JobsController < ApplicationController
  def index
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    @job.account = current_account

    if @job.save
      redirect_to jobs_path, notice: "Successfully created a job."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :location, :status, :job_type)
  end
end
