class TreatmentsController < ApplicationController
  before_action :find_treatment, only: [:show, :edit, :update, :destroy]

  def show
    @procedures = @treatment.procedures
    @bookings = @treatment.bookings.order(start_time: :asc)
    @payments = @treatment.payments
    @total = @treatment.procedures.sum(:price_cents) / 100.0
    @total_bookings_payments = @treatment.bookings.sum(:amount_cents) / 100.0
    @total_other_payments = @treatment.payments.sum(:amount_cents) / 100.0
    @balance = @total - @total_bookings_payments - @total_other_payments
    # this payment is added to allow adding adhoc / regular payments outside appointments
    @payment = Payment.new
  end

  def new
    @treatment = Treatment.new
    @treatment.procedures.build
    authorize @treatment
  end

  def create
    @treatment = Treatment.new(treatment_params)
    authorize @treatment

    if @treatment.save
      patient = @treatment.patient
      redirect_to patient_path(patient)
    else
      render :new
    end
  end

  def edit
    @procedures_count = @treatment.procedures.count
  end

  def update
    return render_edit unless @treatment.update(treatment_params)

    redirect_to treatment_path(@treatment)
  end

  def destroy
    patient = @treatment.patient
    if @treatment.destroy
      flash[:notice] = "Treatment no #{@treatment.id} has been deleted"
      redirect_to patient_path(patient)
    else
      flash_alert
      render :show
    end
  end

  private

  def find_treatment
    @treatment = Treatment.find(params[:id])
    authorize @treatment
  end

  def treatment_params
    params.require(:treatment).permit(:name, :recommendations, :discussion, :patient_id,
                  procedures_attributes: [:id, :procedure, :justification, :price, :completed, :_destroy])
  end

  def render_edit
    flash_alert
    render :edit
  end

  def flash_alert
    flash[:alert] = @treatment.errors.full_messages
  end
end
