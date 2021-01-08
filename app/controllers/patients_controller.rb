class PatientsController < ApplicationController
  before_action :find_patient, only: [:show, :edit, :update]

  def index
    @patients = policy_scope(Patient)
  end

  def show; end

  def edit; end

  def update
    user = @patient.user
    user.skip_reconfirmation!
    if @patient.update(patient_params) && user.update(user_params)
      redirect_to patient_path(@patient)
    else
      flash[:alert] = @patient.errors.full_messages
      render :edit
    end
  end

  private

  def find_patient
    @patient = Patient.find(params[:id])
    authorize @patient
  end

  def patient_params
    params.require(:patient).permit(:dob)
  end

  def user_params
    params.require(:patient).permit(user: [:first_name, :last_name, :mobile, :email])[:user]
  end
end
