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
        format.turbo_stream do
          render turbo_stream: turbo_stream.prepend("applicants_container", partial: "applicants/applicant", locals: { applicant: @applicant })
        end
        format.html { redirect_to @applicant, notice: "Applicant was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @applicant.update(applicant_params)
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("applicant_#{@applicant.id}_detail", partial: "applicants/details", locals: { applicant: @applicant })
        end
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
      params.expect(applicant: [ :first_name, :last_name, :email_address, :phone, :stage, :status, :resume, :job_id ])
    end
end
