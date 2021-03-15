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

    if @payment.save
      redirect_to treatment_path(@treatment)
    else
      render render "treatment/show"
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:amount, :treatment_id)
  end
end
