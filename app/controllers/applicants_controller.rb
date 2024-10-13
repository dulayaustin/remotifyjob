class ApplicantsController < ApplicationController
  include Filterable

  before_action :set_applicant, only: %i[ show edit update destroy change_stage ]

  def index
    @grouped_applicants = filter!(Applicant).within_account(current_account.id).group_by(&:stage)
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
          render turbo_stream: turbo_stream.prepend("applicants_#{@applicant.stage}", partial: "applicants/card", locals: { applicant: @applicant })
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

  def change_stage
    @applicant.update(applicant_params)
    head :ok
  end

  private
    def set_applicant
      @applicant = Applicant.find(params.expect(:id))
    end

    def applicant_params
      params.expect(applicant: [ :first_name, :last_name, :email_address, :phone, :stage, :status, :resume, :job_id ])
    end
end
