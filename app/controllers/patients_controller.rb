class PatientsController < ApplicationController
  before_action :find_patient, except: [:index]

  def index
    # @patients = policy_scope(Patient).order(id: :asc)
    if params[:query].present?
      @patients = policy_scope(Patient).patient_search(params[:query])
    else
      @patients = policy_scope(Patient).order(id: :asc)
    end
  end

  def show
    @bookings = @patient.bookings.order(start_time: :desc)
    @treatments = @patient.treatments.order(id: :desc)
    @medical_forms = @patient.medical_forms.order(id: :desc)
  end

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

  def destroy
    @patient.destroy

    redirect_to patients_path
  end

  def destroy_image
    @image = @patient.images.find(params[:image_id])
    @image.purge

    redirect_to patient_path(@patient)
  end

  def send_password_email
    @patient.user.send_reset_password_instructions
    redirect_to patient_path(@patient), notice: 'Your patient has been notified!'
  end

  def send_sms_routine_reminder
    return missing_mobile_alert unless @patient.user.mobile.present?

    sms_routine_reminder
    redirect_to patient_path(@patient), notice: 'Your patient has been notified!'
  end

  private

  def find_patient
    patient_id = params[:id] || params[:patient_id]
    @patient = Patient.find(patient_id)
    authorize @patient
  end

  def patient_params
    params.require(:patient).permit(:dob, add_images: [], images: [])
  end

  def user_params
    params.require(:patient).permit(user: [:first_name, :last_name, :mobile, :email])[:user]
  end

  def sms_routine_reminder
    dr_name = "Dr #{current_user.last_name}"
    dr_email = "leila.nebia@designdentalclinic.com"
    dr_mobile = current_user.mobile
    patient_name = @patient.user.first_name
    patient_mobile = @patient.user.mobile
    message = "Dear #{patient_name}, it is time for your routine dental check up. Please contact us at #{dr_email} to book an appointment. Regards -- #{dr_name}, Design Dental Clinic. Mobile: #{dr_mobile}"
    sms = TwilioSms.new(from: dr_name, to: patient_mobile, message: message)
    sms.call
  end

  def missing_mobile_alert
    flash[:alert] = 'Error: Patient not notified. Please add patient\'s mobile number first'
    redirect_to patient_path(@patient)
  end
end
