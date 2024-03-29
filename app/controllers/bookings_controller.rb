class BookingsController < ApplicationController
  before_action :find_booking, only: [:show, :edit, :update, :update_booking, :update_amount, :destroy, :send_sms_reminder, :send_sms_confirmation]

  def index
    @bookings = policy_scope(Booking).order(start_time: :asc)
    # @bookings = policy_scope(Booking).paginate(page: params[:page], per_page: 5).order(start_time: :asc)
    @bookingsu = policy_scope(Booking).where('start_time > ?', Time.now).paginate(page: params[:new_bookings], per_page: 5).order(start_time: :asc)
    @bookingsp = policy_scope(Booking).where('start_time < ?', Time.now).paginate(page: params[:old_bookings], per_page: 5).order(start_time: :desc)
  end

  def show
    @doctor = @booking.doctor.user
    @patient = @booking.patient.user
    @note = Note.new
  end

  def new
    @booking = Booking.new(start_time: params[:date], time: params[:time], length: params[:length])
    @booking.booking_services.build
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    authorize @booking
    if policy(User).doctor?
      @booking.doctor = current_user.profile
      set_booking_times

      return render_new unless @booking.save

      redirect_to bookings_path(start_date: booking_params[:start_time])
    elsif policy(User).patient?
      @booking.patient = current_user.profile
      @booking.doctor = Doctor.first
      set_booking_times

      return render_new unless @booking.save

      @booking.amount = @booking.services.first.price
      @booking.state = "pending"
      @booking.save

      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: [{
          name: @booking.services.first.name,
          # images: [@booking.services.first.photo_url],
          amount: @booking.services.first.price_cents,
          currency: 'gbp',
          quantity: 1
        }],
        success_url: booking_url(@booking),
        cancel_url: booking_url(@booking)
      )

      @booking.update(checkout_session_id: session.id)

      redirect_to new_booking_payment_path(@booking)
    end
  end

  # added to create booking from Tui Calendar
  def new_booking
    authorize Booking

    # passing on params from calendar_controller.js
    start_time = DateTime.parse(booking_params[:start_time])
    end_time = DateTime.parse(booking_params[:end_time])
    time = booking_params[:start_time].to_time.strftime("%H:%M")
    length = ((end_time - start_time) * 60 * 24).to_i

    redirect_to new_booking_path(date: start_time.to_date, time: time, length: length)
  end

  def edit
    @services_count = @booking.booking_services.count
  end

  def update
    return render_edit unless @booking.update(booking_params)

    set_booking_times
    return render_edit unless @booking.save

    redirect_to booking_path(@booking)
  end

  def update_booking
    return render_edit unless @booking.update(booking_params)

    set_booking_times
    return render_edit unless @booking.save
  end

  def update_amount
    @booking.update(status: "Completed")
    return flash_alert unless @booking.update(booking_params)

    redirect_to booking_path(@booking)
  end

  def destroy
    if @booking.destroy
      flash[:notice] = "Booking: #{@booking.start_time.strftime('%e %b %Y %H:%M%p')} to #{@booking.end_time.strftime('%e %b %Y %H:%M%p')} deleted"
      redirect_to bookings_path
    else
      render :index
    end
  end

  def send_sms_reminder
    return missing_mobile_alert unless @booking.patient.user.mobile.present?

    @booking.sms_reminder
    redirect_to booking_path(@booking), notice: 'Your patient has been notified!'
  end

  def send_sms_confirmation
    return missing_mobile_alert unless @booking.patient.user.mobile.present?

    @booking.sms_confirmation
    redirect_to booking_path(@booking), notice: 'Your patient has been notified!'
  end

  private

  def find_booking
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def booking_params
    params.require(:booking).permit(:start_time, :end_time, :time, :length, :status,
      :patient_id, :doctor_id, :amount, :treatment_id, :popup_note,
      booking_services_attributes: [:id, :service_id, :_destroy])
  end

  def set_booking_times
    @booking.start_time = Time.zone.parse("#{@booking.start_time.to_date} #{@booking.time}").in_time_zone('UTC')
    @booking.end_time = @booking.start_time + @booking.length.minutes
  end

  def render_new
    flash_alert
    render :new
  end

  def render_edit
    flash_alert
    render :edit
  end

  def flash_alert
    flash[:alert] = @booking.errors.full_messages
  end

  def missing_mobile_alert
    flash[:alert] = 'Error: Patient not notified. Please add patient\'s mobile number first'
    redirect_to booking_path(@booking)
  end
end
