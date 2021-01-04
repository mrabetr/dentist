class UsersController < ApplicationController
  def index
    @users = policy_scope(User).order(:id)
  end

  def patients
    @patients = policy_scope(User).where(profile_type: "Patient").order(:id)
  end

  def new
    @user = User.new
    authorize @user
  end

  def create
    @user = User.new(user_params)
    user_password
    authorize @user
    @user.skip_confirmation!

    if @user.save
      redirect_to root_path
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

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :mobile)
  end

  def user_password
    # replace this with random password generator and send automatic email to renew password
    @user.password = ENV['NEW_USER_PASSWORD']
    # @user.send_reset_password_instructions
  end
end
