class PaymentsController < ApplicationController
  def new
    @booking = current_user.profile.bookings.where(state: 'pending').find(params[:booking_id])
    authorize @booking
  end

  def create
    @payment = Payment.new(payment_params)
    authorize @payment
    @treatment = Treatment.find(params[:treatment_id])
    @payment.treatment = @treatment

    flash_alert unless @payment.save

    redirect_to treatment_path(@treatment)
  end

  private

  def payment_params
    params.require(:payment).permit(:amount, :treatment_id)
  end

  def flash_alert
    flash[:alert] = "Error: " + @payment.errors.full_messages.first + ". Try again."
  end
end
