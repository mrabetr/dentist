class ClientsController < ApplicationController
  before_action :find_client, except: [:index]

  def index
    # @clients = policy_scope(Client).order(id: :asc)
    if params[:query].present?
      @clients = policy_scope(Client).client_search(params[:query])
    else
      @clients = policy_scope(Client).order(id: :asc)
    end
  end

  def show
    @bookings = @client.bookings.order(start_time: :desc)
  end

  def edit; end

  def update
    user = @client.user
    user.skip_reconfirmation!
    if @client.update(client_params) && user.update(user_params)
      redirect_to client_path(@client)
    else
      flash[:alert] = @client.errors.full_messages
      render :edit
    end
  end

  def destroy
    @client.destroy

    redirect_to clients_path
  end

  def destroy_image
    @image = @client.images.find(params[:image_id])
    @image.purge

    redirect_to client_path(@client)
  end

  def send_password_email
    @client.user.send_reset_password_instructions
    redirect_to client_path(@client), notice: 'Your client has been notified!'
  end

  def send_sms_routine_reminder
    return missing_mobile_alert unless @client.user.mobile.present?

    sms_routine_reminder
    redirect_to client_path(@client), notice: 'Your client has been notified!'
  end

  private

  def find_client
    client_id = params[:id] || params[:client_id]
    @client = Client.find(client_id)
    authorize @client
  end

  def client_params
    params.require(:client).permit(:dob, add_images: [], images: [])
  end

  def user_params
    params.require(:client).permit(user: [:first_name, :last_name, :mobile, :email])[:user]
  end

  def sms_routine_reminder
    provider_name = "Dr #{current_user.last_name}"
    provider_email = "leila.nebia@designdentalclinic.com"
    provider_mobile = current_user.mobile
    client_name = @client.user.first_name
    client_mobile = @client.user.mobile
    message = "Dear #{client_name}, it is time for your routine dental check up. Please contact us at #{provider_email} to book an appointment. Regards -- #{provider_name}, Design Dental Clinic. Mobile: #{provider_mobile}"
    sms = TwilioSms.new(from: provider_name, to: client_mobile, message: message)
    sms.call
  end

  def missing_mobile_alert
    flash[:alert] = 'Error: Client not notified. Please add client\'s mobile number first'
    redirect_to client_path(@client)
  end
end
