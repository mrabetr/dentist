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
    @booking = Booking.new(date: params[:date], time: params[:time])
    @booking.booking_services.build
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.doctor = current_user.profile
    @booking.start_time = DateTime.parse([@booking.date, @booking.time].join(' '))
    @booking.end_time = @booking.start_time + @booking.length.minutes
    authorize @booking

    if @booking.save
      redirect_to bookings_path
    else
      render :new
    end
  end

  def edit
    @services_count = @booking.booking_services.count
  end

  def update
    if @booking.update(booking_params)
      redirect_to booking_path(@booking)
    else
      render :edit
    end
  end

  def destroy
    if @booking.destroy
      flash[:notice] = "Booking: #{@booking.start_time.strftime('%e %b %Y %H:%M%p')} to #{@booking.end_time.strftime('%e %b %Y %H:%M%p')} deleted"
      redirect_to bookings_path
    else
      render :index
    end
  end

  private

  def find_booking
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def booking_params
    params.require(:booking).permit(:date, :time, :length, :start_time, :end_time, :status, :patient_id, booking_services_attributes: [:id, :service_id, :_destroy])
  end
end
