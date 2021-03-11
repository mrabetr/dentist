class MedicalFormsController < ApplicationController
  before_action :find_form, only: [:show]

  def new
    @form = MedicalForm.new(patient_id: params[:patient_id])
    # raise
    # @patient = @form.patient
    # @patient = current_user.profile
    # @form.patient = @patient
    authorize @form
  end

  def create
    @form = MedicalForm.new(form_params)
    # raise
    # user = current_user
    user = User.where(email: user_params[:email])[0]
    patient = user.profile
    @form.patient = patient
    authorize @form
    user.skip_reconfirmation!
    user.update(user_params)
    patient.update(patient_params)

    if @form.save
      redirect_to medical_form_path(@form)
    else
      render :new
    end
  end

  def show
    @patient = @form.patient
  end

  private

  def find_form
    @form = MedicalForm.find(params[:id])
    authorize @form
  end

  def user_params
    params.require(:medical_form).permit(user: [:title, :first_name, :last_name,
      :mobile, :email])[:user]
  end

  def patient_params
    params.require(:medical_form).permit(patient: [:street, :city, :postcode,
      :dob, :sex, :communication, :last_visit,
      :gp, :gp_tel, :gp_street, :gp_city, :gp_postcode])[:patient]
  end

  def form_params
    params.require(:medical_form).permit(:anaemia, :diabetes, :epilepsy, :cancer,
      :brain_surgery, :arthritis, :cold_sore, :gatristis, :drug_dependence,
      :blood_pressure, :fainting_blackouts, :headaches_migraines, :allergies,
      :heart_conditions, :rheumatic_fever, :liver_kidney_problems, :chest_problems,
      :joint_replacement_implants, :bad_anaesthesia_reaction, :hospital_treatments,
      :hiv, :pregnant_nursing, :due_date, :smoking, :smoking_frequency, :alcohol,
      :alcohol_frequency, :other_medical_info, :teeth_pain, :teeth_sensitivity,
      :bleeding, :unpleasant_taste, :food_trap, :mouth_ulcers, :grinding_teeth,
      :stained_teeth, :uneven_teeth, :black_filling, :cracked_teeth, :missing_teeth,
      :crooked_teeth, :uncomfortable_dentures, :bad_breath, :other_smile_info,
      :patient_id)
  end
end
