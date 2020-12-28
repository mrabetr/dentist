class PaymentsController < ApplicationController
  def new
    @booking = current_user.profile.bookings.where(state: 'pending').find(params[:booking_id])
    authorize @booking
  end
end
