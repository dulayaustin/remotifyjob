class ApplicantsController < ApplicationController
  before_action :set_applicant, only: %i[ show edit update destroy ]

  def index
    @applicants = Applicant.all
  end

  def show
  end

  def new
    @applicant = Applicant.new
  end

  def edit
  end

  def create
    @applicant = Applicant.new(applicant_params)

    respond_to do |format|
      if @applicant.save
        format.html { redirect_to @applicant, notice: "Applicant was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @applicant.update(applicant_params)
        format.html { redirect_to @applicant, notice: "Applicant was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @applicant.destroy!

    respond_to do |format|
      format.html { redirect_to applicants_path, status: :see_other, notice: "Applicant was successfully destroyed." }
    end
  end

  private
    def set_applicant
      @applicant = Applicant.find(params.expect(:id))
    end

    def applicant_params
      params.expect(applicant: [ :first_name, :last_name, :email, :phone, :stage, :status, :job_id ])
    end
end
