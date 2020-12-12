class BookingsController < ApplicationController
  before_action :find_booking, only: [:show, :edit, :update, :destroy]

  def index
    @bookings = policy_scope(Booking).order(start_time: :asc)
  end

  def show
    @doctor = @booking.doctor.user
    @patient = @booking.patient.user
  end

  def new
    @booking = Booking.new
    @booking.booking_services.build
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.doctor = current_user.profile
    authorize @booking

    if @booking.save
      redirect_to bookings_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @booking.update(booking_params)
      redirect_to booking_path(@booking)
    else
      render :edit
    end
  end

  def destroy
    @booking.destroy

    redirect_to bookings_path
  end

  private

  def find_booking
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def booking_params
    params.require(:booking).permit(:start_time, :end_time, :status, :patient_id, booking_services_attributes: [:id, :service_id])
  end
end
