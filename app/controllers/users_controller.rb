class UsersController < ApplicationController
  def index
    @users = policy_scope(User).order(:id)
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
    redirect_to root_path
  end
end
