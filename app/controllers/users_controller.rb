class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update]

  def index
    @users = policy_scope(User).order(:id)
  end

  def clients
    @clients = policy_scope(User).where(profile_type: "Client").order(:id)
  end

  def new
    # Providing params to User.new is for pre-filling details from requests
    @user = User.new(email: params[:email], first_name: params[:first_name],
                      last_name: params[:last_name], mobile: params[:mobile])
    authorize @user
  end

  def create
    @user = User.new(user_params)
    user_password
    authorize @user
    @user.skip_confirmation!

    if @user.save
      redirect_to bookings_path, notice: 'Your client was added successfully!'
    else
      flash[:alert] = @user.errors.full_messages
      render :new
    end
  end

  def edit; end

  def update
    @user.skip_reconfirmation!

    if @user.update(user_params)
      redirect_to client_path(@user.profile)
    else
      flash[:alert] = @user.errors.full_messages
      render :new
    end
  end

  def impersonate
    user = User.find(params[:id])
    authorize user

    impersonate_user(user)
    redirect_to root_path
  end

  def stop_impersonating
    authorize User

    stop_impersonating_user
    redirect_to users_path
  end

  private

  def find_user
    @user = User.find(params[:id])
    authorize @user
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :mobile)
  end

  def user_password
    # replace this with random password generator and send automatic email to renew password
    @user.password = ENV['NEW_USER_PASSWORD']
    # @user.send_reset_password_instructions
  end
end
