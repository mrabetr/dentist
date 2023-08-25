class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # scope.all
      if provider_or_admin?
        scope.all
      else
        scope.where(client: user.profile)
      end
    end
  end

  def index?
    provider_or_admin?
  end

  def show?
    provider_admin_or_client_owner?
  end

  def create?
    # update to true when ready to allow client to add a new booking
    provider?
  end

  def new_booking?
    new?
  end

  def update?
    provider_owner?
  end

  def update_booking?
    update?
  end

  def update_amount?
    update?
  end

  def destroy?
    provider_owner?
  end

  def send_sms_reminder?
    provider?
  end

  def send_sms_confirmation?
    provider?
  end

  private

  def provider?
    user.provider
  end

  def provider_owner?
    user == record.provider.user
  end

  def provider_admin_or_client_owner?
    user.provider || user.admin || user == record.client.user
  end
end
